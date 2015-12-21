//
//  main.m
//  MontyPythonTest
//
//  Created by Conor Sweeney on 12/11/15.
//  Copyright © 2015 Conor Sweeney. All rights reserved.
//

#import <Foundation/Foundation.h>



NSString* montyAlgo (int doorValue){
    //check that given door value is 1,2,3
    if (doorValue >0 && doorValue < 4) {
        //declare flags
        int flag = 0;
        int flag1 = 0;
        
        //dictionary for prize values
        NSMutableDictionary *valueDictionary = [[NSMutableDictionary alloc]init];
        [valueDictionary setValue:@"goat" forKey:@"1"];
        [valueDictionary setValue:@"goat" forKey:@"2"];
        [valueDictionary setValue:@"car" forKey:@"3"];
        
        //put numbers into an array in a random order
        NSMutableArray *arryRandomNumber=[[NSMutableArray alloc]init];
        while (arryRandomNumber.count<3) {
            NSInteger randomNumber =1+arc4random()%3;
            if (![arryRandomNumber containsObject:[NSString stringWithFormat:@"%d",(int)randomNumber]])
            {
                [arryRandomNumber addObject:[NSString stringWithFormat:@"%d",(int)randomNumber]];
            }
            continue;
        }
        
        //set key values to array of random numbers
        NSString *door1Key = [arryRandomNumber objectAtIndex:0];
        NSString *door2Key = [arryRandomNumber objectAtIndex:1];
        NSString *door3Key = [arryRandomNumber objectAtIndex:2];

        //set the key value for the door chosen
        NSString *myDoorKey = [arryRandomNumber objectAtIndex:(doorValue - 1)];
        //NSString *myDoorValue = [valueDictionary objectForKey:myDoorKey];
        
        //generate key for the door shown by the host
        //make sure it is not the same as the given door
        NSString *doorShownKey = [NSString stringWithFormat:@"%d",(((int)arc4random_uniform(2))+1) ];
        if ([doorShownKey isEqualToString:myDoorKey]) {
            if ([doorShownKey isEqualToString:@"1"]) {
                doorShownKey = @"2";
            }
            else if ([doorShownKey isEqualToString:@"2"]){
                doorShownKey = @"1";
            }
        }
        //NSString *doorShownValue = [valueDictionary objectForKey:doorShownKey];
        
        //find out what door number the shown door is
        if ([doorShownKey isEqualToString:door1Key]) {
            flag = 1;
        }
        else if ([doorShownKey isEqualToString:door2Key]){
            flag = 2;
        }
        else if ([doorShownKey isEqualToString:door3Key]){
            flag = 3;
        }
        
        //Get the value for the door not chosen and its key
        NSString *doorNotChosenKey;
        NSMutableArray *numberSet = [[NSMutableArray alloc]init] ;
        [numberSet addObject:doorShownKey];
        [numberSet addObject:myDoorKey];
        for (int y= 1; y < 4; y++) {
            NSString *tempKey = [NSString stringWithFormat:@"%d",y];
            if ([tempKey isEqualToString:[numberSet objectAtIndex:0]]) {
                continue;
            }
            else if ([tempKey isEqualToString:[numberSet objectAtIndex:1]]) {
                continue;
            }
            else{
                doorNotChosenKey = tempKey;
                break;
            }
        }
        NSString *doorNotChosenValue =[valueDictionary objectForKey:doorNotChosenKey];
        //find the door number for door not chosen
        if ([doorNotChosenKey isEqualToString:door1Key]) {
            flag1 = 1;
        }
        else if ([doorNotChosenKey isEqualToString:door2Key]){
            flag1 = 2;
        }
        else if ([doorNotChosenKey isEqualToString:door3Key]){
            flag1 = 3;
        }

        return doorNotChosenValue;
    }
    //if number is not 1,2,or 3 tell user
    else
        
    return @"Not a door";
    
}

//function to test the algorithim and count results
void montyAlgoCounter (int doorAttempts){
    long goatCounter = 0;
    long carCounter = 0;
    int doorNumber = arc4random_uniform(3)+1;
    for (int i = 0; i < doorAttempts; i++) {
        NSString *tempValue =  montyAlgo(doorNumber);
        if ([tempValue isEqualToString:@"goat"]) {
            goatCounter++;
        }
        else if ([tempValue isEqualToString:@"car"]){
            carCounter++;
        }
    }
    NSLog(@"\n\nNumber of Attempts %d\n\nPrizes behind the door that is not chosen:\nGoat - %ld\nCar - %ld\n\n",doorAttempts,goatCounter,carCounter);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //enter door number that you choose
        montyAlgoCounter(100);
    }
    return 0;
}

