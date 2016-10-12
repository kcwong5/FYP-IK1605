//
//  ViewController.m
//  HKDataCollector
//
//  Created by Wong Sam on 11/10/2016.
//  Copyright © 2016年 Wong Sam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *ageLabel;
@property (nonatomic, weak) IBOutlet UILabel *weightLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    healthStore = [HKHealthStore new];
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        [healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            NSLog(@"Success: %d and Error: %@", success, error);
        }];
    }
    
}

-(NSSet *) dataTypesToWrite{
    return nil;
}

-(NSSet *) dataTypesToRead{
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *heartRate = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    HKQuantityType *walkingRunningDistance = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    HKCharacteristicType *biologicalSex = [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    HKCharacteristicType *birthday = [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    
    return [NSSet setWithObjects:heightType, weightType, heartRate, walkingRunningDistance, biologicalSex, birthday, nil];
}

//Show the Age
- (IBAction)readBirthDate:(id)sender {
    NSError *error;
    NSDate *dateOfBirth = [healthStore dateOfBirthWithError:&error];
    if (!dateOfBirth) {
        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
    }
    NSDate *now = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:dateOfBirth
                                       toDate:now
                                       options:NSCalendarWrapComponents];
    self.ageLabel.text = [@(ageComponents.year) stringValue];
}

//Show the Weight
-(IBAction)readWeight:(id)sender{
    double usrWeight = 0.0;
    //HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    
    
    self.weightLabel.text = [@(usrWeight) stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
