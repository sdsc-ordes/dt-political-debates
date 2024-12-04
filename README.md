# dt-political-debates
Digital Twin on Political Debates

``` mermaid
graph TD
    ExternalUNDatabase[External UN Database] --> UNScrapper[ODTP UN Scrapper]

    subgraph ODTP
        UNScrapper --> UNMediaDataloader[UN Media Dataloader]

        UNMediaDataloader --> ODTPPyannoteWhisper[ODTP Pyannote Whisper]
        ODTPPyannoteWhisper --> ODTPTranslation[ODTP Translation]

    end
    ODTPTranslation --> UNS3[Political Debates S3]
    ODTPTranslation --> UNMongoDB[Political Debates MongoDB]

    UNS3 --> Frontend[Political Debates Frontend]
    UNMongoDB <--> Frontend[Political Debates Frontend]
    UNMongoDB <--> UNSolr
    UNSolr <--> Frontend
```
