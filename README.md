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
