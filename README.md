# dt-political-debates
Digital Twin on Political Debates

``` mermaid
graph TB
    ExternalUNDatabase[External UN Database] --> UNScrapper[ODTP UN Scrapper]

    subgraph ODTP
    direction TB
        UNScrapper --> ODTPPyannoteWhisper[Diarizarion & Transcription]
    end
    ODTPPyannoteWhisper --> UNS3[Political Debates S3]

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
- `odtp-pyannote-whisper`. Component to diarize and transcribe audios and videos
    - https://github.com/sdsc-ordes/odtp-pyannote-whisper

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

### Tutorial to run the pipeline in ODTP

This pipeline can be executed in ODTP by executing `dt-political-debates.sh`

1. Clone this repository
2. Edit `dt-political-debates.sh` with the ODTP user email
3. Edit the secrets and other parameters.
4. Run the bash script: `sh dt-political-debates.sh`

Alternatively, you can add the components to the GUI and manually run the execution. 

### How to use this tool with a custom file?

In order to run the `out-py annotate-whisper` module, it is necessary to start with a valid metadata JSON file. You can obtain one by fetching the data from the scrapper or create a synthetic one manually. This is the example of a synthetic one you can use to generate yours. It should validate against `schemas/unogDigitalRecordingMetadataMinimalSchema.json`. 

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

This metadata should be placed in the `odtp-input` folder for the `odtp-pyannote-whisper` component. In case you are using the outcome of the scrapper you shouldn't manually create this initial metadata file. 


## Changelog

- v1.0.0
    - Basic project structure, schemas, and scripts. 

## Next steps

- [ ] odtp-trascription2pdf component
- [ ] data-downloader component
- [ ] datauploader component
- [ ] faces indentifier component
- [ ] docker-compose 
- [ ] odtp compatibility
- [ ] documentation