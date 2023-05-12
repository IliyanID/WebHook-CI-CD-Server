export type CommonConfig = {
    ConfigType:'CICD'|'AmazonAlexa'|'PowerAutomate'
    ExternalResources?:CommonConfig[],
    Config:object
}