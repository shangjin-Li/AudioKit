//
//  AKBrownianNoiseAudioUnit.mm
//  AudioKit
//
//  Created by Aurelius Prochazka, revision history on Github.
//  Copyright © 2017 Aurelius Prochazka. All rights reserved.
//

#import "AKBrownianNoiseAudioUnit.h"
#import "AKBrownianNoiseDSPKernel.hpp"

#import "BufferedAudioBus.hpp"

#import <AudioKit/AudioKit-Swift.h>

@implementation AKBrownianNoiseAudioUnit {
    // C++ members need to be ivars; they would be copied on access if they were properties.
    AKBrownianNoiseDSPKernel _kernel;
    BufferedInputBus _inputBus;
}
@synthesize parameterTree = _parameterTree;

- (void)setAmplitude:(float)amplitude {
    _kernel.setAmplitude(amplitude);
}

standardKernelPassthroughs()

- (void)createParameters {

    standardSetup(BrownianNoise)

    // Create a parameter object for the amplitude.
    AUParameter *amplitudeAUParameter = [AUParameter parameter:@"amplitude"
                                                          name:@"Amplitude"
                                                       address:amplitudeAddress
                                                           min:0.0
                                                           max:1.0
                                                          unit:kAudioUnitParameterUnit_Generic];

    // Initialize the parameter values.
    amplitudeAUParameter.value = 1;

    _kernel.setParameter(amplitudeAddress, amplitudeAUParameter.value);

    // Create the parameter tree.
    _parameterTree = [AUParameterTree tree:@[
        amplitudeAUParameter
    ]];


	parameterTreeBlock(BrownianNoise)
}

AUAudioUnitGeneratorOverrides(BrownianNoise)

@end


