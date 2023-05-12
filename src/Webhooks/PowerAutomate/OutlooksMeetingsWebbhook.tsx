import { app } from "../../server"
import { Request, Response, NextFunction } from 'express'
import { ConfigSchemaType } from "./Types/ConfigSchemaType"
import Ajv from 'ajv'
import ConfigSchema from './Schemas/ConfigSchema.json'

const ajv = new Ajv({allErrors:true})
const validator = ajv.compile(ConfigSchema)
export const OutlooksMeetingWebhook = (webhook:string,config:ConfigSchemaType) => {
    const valid = validator(config)
    if(!valid){
        throw new Error(`Misconfigured Config for OutlooksMeetingsWebhook. 
        Error: \n ${validator.errors?.map(error=>error.message + '\n')}
        Received: \n ${JSON.stringify(config,null,2)}
        Schema: \n ${JSON.stringify(ConfigSchema,null,2)}`)
    }
    app.post(webhook,(req:Request,res:Response,next:NextFunction)=>{

    })
}