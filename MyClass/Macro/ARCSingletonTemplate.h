//
//  ARCSingletonTemplate.h
//  MiuYoga
//
//  Created by uchiha on 2018/2/2.
//  Copyright © 2018年 creditease. All rights reserved.
//

#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
   +(className *)shared##className;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(className)    \
\
   +(className *)shared##className                  \
      {                                               \
         static className *shared##className = nil;   \
         static dispatch_once_t onceToken;            \
         dispatch_once(&onceToken, ^{                 \
         shared##className = [[self alloc] init]; \
      });                                          \
      return shared##className;                    \
   }                                             \

