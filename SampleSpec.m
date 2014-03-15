//
//  SampleSpec.m
//  ProjectBarbosa
//
//  Created by Yuriy Dyrenko on 2014-03-15.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 17;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(43)];
    });
});

SPEC_END