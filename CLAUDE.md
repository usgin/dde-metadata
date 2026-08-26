# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Workspace-level context (sibling clones, the newer `usgin/geonetwork-DDE` line at
`C:\GithubC\geonetwork\core-geonetwork`) is in `../CLAUDE.md`.

## Purpose

Two deliverables live here:

1. **The DDE metadata standard** — an XML Schema plus its normative prose document, defining
   namespace `https://www.ddeworld.org/resource/standards/dde/ds01/metadata/1.0`, root element
   `metadata:MD_Metadata`.
2. **A GeoNetwork catalog configured for DDE** — the `DDEcore-geonetwork` submodule, which customizes
   GeoNetwork's ISO 19115-3:2018 schema plugin so records can be edited and exchanged in both DDE and
   ISO form. The bridge between the two is a pair of XSLT crosswalks.

Remote: `https://github.com/usgin/dde-metadata.git`. Currently checked out on
`GeoNetworkConfiguration`.

The original remote, `https://opencode.deep-time.org/dde/dde-medata.git`, is **gone** — that GitLab
instance refuses connections on both 80 and 443 while the rest of the DDE web estate is up, so it
appears decommissioned. This repo was mirrored to GitHub on 2026-08-26 (all six branches) and
`origin` repointed there.

## Content is split across branches — check before assuming something is missing

Branches were never merged; each carries files the others lack. `git ls-tree --name-only <branch>`
before concluding a file doesn't exist.

| Branch | Tip | Holds |
|---|---|---|
| `GeoNetworkConfiguration` | 2024-04-23 | **checked out.** The `DDEcore-geonetwork` submodule. |
| `main` | 2024-10-24 | SKOS vocabularies at top level, `dde-2023/`, `Documents/` (UI-problem notes, decks), `geonetworkQuestions.txt`, transform test output. |
| `geonetwork` | 2024-04-22 | `vocabularies/` (same SKOS, foldered), `GeoNetworkRelease/geonetwork.war` — a **git-LFS pointer**, 134 bytes on disk. Its LFS object lived on the retired GitLab and is **unrecoverable**; the pointer is now dangling. |
| `updates2024-02`, `UpdateTransforms`, `UpdateTransforms-emerald` | Feb–Apr 2024 | Older transform/spec/example iterations. |

The SKOS vocabularies (`TopicCategorySKOS`, `resourceTypeSKOS`, `serviceTypeSKOS`,
`acquisitionCodeSKOS`, each as `.rdf`/`.ttl`/`.xml`) are the DDE controlled vocabularies loaded into
GeoNetwork as thesauri. They are **not** on the checked-out branch.

## The DDE schema

- `DDEMetadataXSD_20240103.xsd` — current. Supersedes `DDEMetadataXSD_20231207.xsd` and
  `DDEMetadata20231103.xsd`, both kept for reading older instances.
- `DDE_Metadata_standard_editversion2.docx` — the working prose spec; edits to the XSD and to this
  document go together. The frozen 2023-11-07 release (docx / pdf / launch pptx) is in
  `release20231107/` and should not be modified.
- `ExampleXML/` — the regression fixtures. Records appear in matched sets so a crosswalk can be
  checked in both directions, e.g. `ArizonaLithostratigraphyOneGeologyDDE.xml` /
  `...ISO19139.xml` / `AzLithostratigraphyOneGeologyDDE20240103.xml`, and the same for the CGS
  bedrock lithostratigraphy record. `minimalInstanceDDE.xml` is the smallest valid DDE document;
  `ddeTransformTest-DDE.xml` and `ddeTransformTestISO19115-3Service.xml` are the round-trip pair.
- `ResourceTypes.xlsx` (untracked) — working comparison of GeoNetwork's `ResourceType.java` values
  against the DDE resource-type codelist. Decide before committing; it is analysis input, not a build
  artifact.

## Crosswalks — edit the plugin copies, not `transforms/`

`transforms/` is the 2023-10-30 standalone pair and is **superseded**. The live stylesheets are inside
the submodule, and they have diverged a long way (`DDEutilities.xsl`: 220 lines in `transforms/`,
1071 in the plugin).

```
transforms/                                   # legacy, standalone
  ddeToISO19115-3_20231030.xsl                # DDE -> ISO 19115-3
  ISO19115-3ToDDE_20231030.xsl                # ISO -> DDE
  utility/{DDEutilities,create19115-3Namespaces,dateTime,multiLingualCharacterStrings}.xsl

DDEcore-geonetwork/schemas/iso19115-3.2018/src/main/plugin/iso19115-3.2018/convert/   # live
  fromDDE-20240405.xsl        # DDE -> ISO 19115-3   (GeoNetwork from*/to* naming)
  toDDE_20240204.xsl          # ISO 19115-3 -> DDE
  fromDDE-any.xsl             # dispatcher; imports fromDDE-20240405 + fromISO19139-DDE
  fromISO19139-DDE.xsl        # legacy ISO 19139 input
  ddeToISO19115-3_20240208.xsl, ISO19115-3ToDDE_20240204.xsl   # same directions, legacy names
  utilityDDE/                 # DDE forks of stock GeoNetwork utilities
    DDEutilities.xsl  create19115-3NamespacesDDE.xsl  dateTimeDDE.xsl
    multiLingualCharacterStringsDDE.xsl  fromISO19115-3.2014DDE.xsl
    iso-19115-to-usgin-19115-dataDDE.xslt
    ISO19139mappingDDE/{coreDDE,CI_CitationDDE,CI_ResponsiblePartyDDE,DQ_DDE,SRV_DDE,defaultsDDE}.xsl
```

Rules the existing code follows:

- XSLT 2.0 / Saxon throughout. Every crosswalk repeats the full ISO 19115-3 prefix block (`mdb`,
  `mri`, `cit`, `gex`, `mcc`, `mrd`, `srv`, `gco`, …) — copy it wholesale rather than trimming.
- Customization is **additive**: DDE variants get a `DDE` suffix and sit in `utilityDDE/` /
  `ISO19139mappingDDE/`, leaving upstream `utility/` and `ISO19139/mapping/` untouched. Keep that
  separation so upstream merges stay tractable.
- `srv` namespace version differs between stylesheets (`2.0` vs `2.1`). A global replace across them
  has broken the build before — change one file at a time.
- New files should use GeoNetwork's `fromXXX.xsl` / `toXXX.xsl` convention (direction relative to the
  plugin's own ISO schema).

### Checking a crosswalk change

No test harness exists here. Run the stylesheet over a matched pair from `ExampleXML/` with Saxon 9+
and validate the output:

```bash
java -jar saxon.jar -s:ExampleXML/minimalInstanceDDE.xml -xsl:DDEcore-geonetwork/schemas/iso19115-3.2018/src/main/plugin/iso19115-3.2018/convert/fromDDE-20240405.xsl -o:out.xml
```

DDE output validates against `DDEMetadataXSD_20240103.xsd`; ISO output against the schemas bundled
under the plugin's `schema/` directory, resolved through its `oasis-catalog.xml`.

## The GeoNetwork submodule

`DDEcore-geonetwork` → `https://github.com/usgin/DDEcore-geonetwork.git`, branch `DDEconfig`.
Initialize with `git submodule update --init --recursive`.

That mirror was made from this machine's clone after the GitLab original went offline, and its
**history was rewritten**: the 273 MB `geonetwork.war` exceeded GitHub's 100 MB blob limit and was
stripped, which emptied the `add war file` commit (`f714717`) so it was pruned. Every SHA therefore
differs from the original fork, and the gitlink now records the rewritten `fix import paths` commit,
`c07e33ff`. Only the two local branches (`DDEconfig`, `main`) were mirrored — the 87 upstream
branches and 109 tags are all available from `geonetwork/core-geonetwork` and were skipped.

The submodule checkout in *this* working tree still sits on the pre-rewrite history (plus an
uncommitted `loc/eng/strings.xml` edit), so `git status` reports it as modified. A fresh
`git clone --recurse-submodules` resolves correctly; to realign this copy, commit or stash that edit
first, then reset the submodule to `origin/DDEconfig`.

DDE-specific customization is confined to
`schemas/iso19115-3.2018/src/main/plugin/iso19115-3.2018/`:

- `layout/config-editor.xml` — `<view name="ddeview" default="true">`, the DDE editing form. Eight
  flat-mode tabs: `basicmetadata`, `firstdetail`, `extent`, `imagery`, `service`,
  `relatedresource`, `dde-distributionInfo`, `metadatametadata`. Fields are declared as XPaths into
  the ISO 19115-3 instance, with `<action type="add">`/`<template><snippet>` blocks supplying the
  ISO element skeleton for empty values.
- `convert/` — the crosswalks above.
- `formatter/dde/view.xsl` — DDE output view.
- `loc/eng/strings.xml` — DDE labels and help text (currently modified in the submodule working tree).
- `update-fixed-info.xsl` — normalization applied after every edit.

Outside the plugin, the fork also disables the ISO 19110 and Dublin Core schema plugins in
`schemas/pom.xml` and `web/pom.xml`, and carries Elasticsearch credentials in the root `pom.xml`.
DDE codelist references point at `https://www.ddeworld.org/resource/codelist/...`.

Note the fork's history contains a committed 285 MB `geonetwork.war` — clones and fetches are slow,
and build output must never be added.

### Build and deploy

Per `../dde-medata/Deploy Geonetwork instructions2024-07.pdf` and
`GeoNetwork configuration work2024-07.pdf`:

```bash
mvn clean install -DskipTests
```

Run inside `DDEcore-geonetwork`; produces `web/target/geonetwork.war`, which is copied into Tomcat's
`webapps/`. Elasticsearch can be fetched into the tree with:

```bash
cd es && mvn install -Pes-download
```

Target stack is Tomcat 9.0.85 with Elasticsearch 8.11.3 (Kibana 8.11.3 alongside); the catalog serves
at `http://localhost:8080/geonetwork`. For dev, the notes disable ES security in `elasticsearch.yml`
(`xpack.security.enabled: false`, `xpack.security.enrollment.enabled: false`) and set
`es.username` / `es.password` in the deployed `webapps/geonetwork/WEB-INF/config.properties`.

**JDK:** the build targets **JDK 11**; the JDK on PATH on this machine is Temurin 21, so set
`JAVA_HOME` explicitly first.

**Windows build gotcha from the notes:** Maven fails with file-access errors while an editor or
Explorer window holds the source tree open. Close them and rebuild before investigating the message.

## Working-tree state — confirm before committing

- ~302 uncommitted deletions: the whole `dde-2023/` tree (an earlier schema-plugin copy lifted from a
  deployed Tomcat instance) is removed from disk but still in `HEAD`. In-progress consolidation, not
  damage. It still exists on `main`.
- The `DDEcore-geonetwork` submodule pointer is modified and the submodule itself is dirty.
- `core-geonetwork/` is an empty `.gitkeep` placeholder — an abandoned attempt to vendor the
  GeoNetwork source directly (the commit messages record it). The real dependency is the
  `DDEcore-geonetwork` submodule; don't populate it.
- `.gitignore` lists Maven/Eclipse patterns and ignores `.project`, but a `.project` file is present
  and tracked.
