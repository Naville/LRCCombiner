//
//  main.m
//  LRCCombiner
//
//  Created by Zhang Naville on 15/4/30.
//  Copyright (c) 2015年 Naville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLLRCParser.h"
int main(int argc, const char * argv[]) {
    NSDictionary* nulldict=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"LRCTIME",@"",@"LRC",@"0",@"TIME",nil];
    @autoreleasepool {
        // insert code here...
        printf("LRC Combiner By Naville.Zhang\n");
        NSMutableArray* array1=[NSMutableArray array];
        for(int i=1;i<argc-1;i++){
            NSString* lrc1=[NSString stringWithContentsOfFile:[NSString stringWithUTF8String:argv[i]] encoding:NSUTF8StringEncoding error:nil];
           // NSLog(@"%@",lrc1);
            
            NSMutableArray* tmparray=[[[DLLRCParser alloc] init] parseLRC:lrc1];
  // NSLog(@"%@",tmparray);
            
            [array1 addObjectsFromArray:tmparray];

            
            
        }
        NSLog([NSString stringWithUTF8String:argv[argc-1]]);
        NSString* output=[[[DLLRCParser alloc] init] Combiner:array1];
        NSString* OUTPATH=[NSString stringWithUTF8String:argv[argc-1]];
        NSMutableData* outdata=[NSMutableData dataWithData:[output dataUsingEncoding:NSUTF8StringEncoding]];
        do{
            
        }
        while([outdata rangeOfData:[NSData dataWithBytes:"\x1A" length:2] options:NSDataSearchAnchored range:NSMakeRange(0, [outdata length])]);
        [outdata writeToFile:OUTPATH atomically:YES];
        //[components writeToFile:[NSString stringWithFormat:@"%@.plist",OUTPATH] atomically:YES];
    }
    return 0;
}
