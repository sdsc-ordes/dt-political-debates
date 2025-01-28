# dt-political-debates
Digital Twin on Political Debates

``` mermaid
graph TB
    ExternalUNDatabase[External UN Database] --> UNScrapper[ODTP UN Scrapper]

    subgraph ODTP
    direction TB
        UNScrapper --> UNMediaDataloader[UN Media Dataloader]

        UNMediaDataloader --> ODTPPyannoteWhisper[ODTP Pyannote Whisper]
        ODTPPyannoteWhisper --> ODTPTranslation[ODTP Translation]

        ODTPTranslation --> S3Dataloader[S3 Dataloader]
    end
    S3Dataloader --> UNS3[Political Debates S3]

    subgraph Webplatform
    direction TB
        UNS3 --> UNMongoDB

        UNMongoDB <--> Backend["Backend (API and Tools)"]
        UNMongoDB --> UNSolr[UN Solr]
        UNSolr --> Backend["Backend (API and Tools)"]
        Backend <--> Frontend[Political Debates GUI]
    end
```

## List of components

- `odtp-unog-digitalrecordings-scrapper`. Component to scrap and download metadata from the UNOG Digital Recordings platform. 
    - https://github.com/sdsc-ordes/odtp-unog-digitalrecordings-scrapper
- `odtp-unog-digitalrecordings-downloader`. Component to download a recording from the UNOG Digital Recordinfs platform.
    - To be developed. 
- `odtp-pyannote-whisper`. Component to diarize and transcribe audios and videos
    - https://github.com/sdsc-ordes/odtp-pyannote-whisper
- `odtp-trascription2pdf`. Component to generate pdfs from a transcription json file. **Still under heavy development**
    - https://github.com/sdsc-ordes/odtp-transcriptions2pdf
- `odtp-faces-indentifier`. Component to identify faces from video frames.
    - To be developed. 
- `odtp-s3datauploader`. Component to upload data output to an S3 folder
    - To be developed. 

The following part of the projects are not odtp components.
- `debates-dataloader`. Tool to upload files to the S3 bucket, MongoDB, and Solr.
    - https://github.com/sdsc-ordes/debates-dataloader
- `debates-solr`. Solr setup for debates ui.
    - https://github.com/sdsc-ordes/debates-solr
- `debates-ui`. Frontend for the Political Debates project. 
    - https://github.com/sdsc-ordes/debates-ui
- `political-debates-ui`. Full deployment of all GUI components.
    - https://github.com/sdsc-ordes/political-debates-ui


## How to run this pipeline?

### How to create an initial json file?

In order to fully run this pipeline is necesary to start by a valid metadata json file. You can obtain one by fetching the data from the scrapper or create a synthetic one manually. This is the example of a synthetic one you can use to generate yours. It should validate against `schemas/unogDigitalRecordingMetadataMinimalSchema.json`. 

``` json
{
    "$schema": "https://raw.githubusercontent.com/sdsc-ordes/dt-political-debates/refs/heads/main/schemas/unogDigitalRecordingMetadataMinimalSchema.json",
    "version": "1.0",
    "metadata": {
      "title": "HRC_20220929T0000",
      "date": "2022-09-29",
      "time": "00:00",
      "url": "http://example.com",
      "tags": ["HRC_20220929T0000"],
      "summary": "",
      "labels": {}
    },
    "channels": [
      {
        "id": "video",
        "type": "video",
        "name": "Main Video Channel",
        "data": "HRC_20220929T0000.mp4",
        "tags": ["main", "video"]
      },
      {
        "id": "original",
        "type": "audio",
        "name": "Original Audio Channel",
        "data": "HRC_20220929T0000-original.wav",
        "tags": ["original", "audio"]
      }
    ],
    "annotations": [
    ]
  }
```

### Tutorial to run the pipeline in ODTP

TBD

### How to run the pipeline with Docker Compose

TBD

## Changelog

- v1.0.0
    - Basic project structure, schemas, and scripts. 

## Roadmap

- [ ] odtp-trascription2pdf component
- [ ] data-downloader component
- [ ] datauploader component
- [ ] faces indentifier component
- [ ] docker-compose 
- [ ] odtp compatibility