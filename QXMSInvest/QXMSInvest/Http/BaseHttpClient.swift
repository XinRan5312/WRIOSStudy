//
//  BaseHttpClient.swift
//  QXMSInvest
//
//  Created by 新然 on 2017/6/22.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

import Foundation
import Alamofire
class BaseHttpClient : NSObject {
    
    
//    case MSSharePref.ServerHost.ENV_TEST:
//    return "http://101.200.156.252:9081/";
//    //                return "http://10.0.110.67:6500/"; // ZK
//    case MSSharePref.ServerHost.ENV_PERFORMANCE:
//    return "http://mjstest.minshengjf.com:6101/";
//    case MSSharePref.ServerHost.ENV_PRERELEASE:
//    initSSLContext(R.raw.server_prerelease, R.raw.client_prerelease);
//    return "https://mjsytc.minshengjf.com:6108/";
//    case MSSharePref.ServerHost.ENV_PRODUCT:
//    initSSLContext(R.raw.server_product, R.raw.client_product);
//    return "https://www.mjsfax.com:6108/";
    let baseUrl="http://101.200.156.252:9081/"
    
    let headers:[String:String]=["platForm":"android","UserAgent":"kkkkkkk"]
    
    
    
}
