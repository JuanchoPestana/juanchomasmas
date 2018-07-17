//
//  ViewControllerMain.h
//  Compis
//
//  Created by Juancho Pestana on 4/30/18.
//  Copyright © 2018 Juancho Pestana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "y.tab.h"
#import "Compis-Swift.h"
#import "ConectorParser.h"

@interface ViewControllerMain : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *input_text_view;
@property (weak, nonatomic) IBOutlet UITextView *output_text_view;

- (IBAction)recursion:(id)sender;
- (IBAction)fibonacci:(id)sender;
- (IBAction)factorial:(id)sender;
- (IBAction)multi_arreglo:(id)sender;
- (IBAction)buscar_arreglo:(id)sender;
- (IBAction)ordenar_arreglo:(id)sender;




- (IBAction)ejecutar:(id)sender;

@end
