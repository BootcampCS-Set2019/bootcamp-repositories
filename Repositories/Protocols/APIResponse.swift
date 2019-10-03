//
//  APIResponse.swift
//  Repositories
//
//  Created by elton.faleta.santana on 03/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import MTGSDKSwift

public typealias APIResponse<T> = (T?, NetworkError?) -> Void
