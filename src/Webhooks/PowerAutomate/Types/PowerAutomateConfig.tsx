import { CommonConfig } from "../../../Types/CommonConfig";


export interface PowerAutomateConfig extends CommonConfig{
    ConfigType:'PowerAutomate',
    Config:{
        data:boolean
    }
}
