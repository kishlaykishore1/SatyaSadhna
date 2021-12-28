//
//  GypsyCoursesDataVC.m
//  SatyaSadhna
//
//  Created by kishlay kishore on 22/04/21.
//  Copyright © 2021 Roshan Singh Bisht. All rights reserved.
//

#import "GypsyCoursesDataVC.h"
#import "HomeService.h"

@interface GypsyCoursesDataVC ()<UIWebViewDelegate> {
  NSString *strin;
  NSString *strhindi;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation GypsyCoursesDataVC
@synthesize isFromView,currentView;



- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setAddRightBarBarBackButtonEnabled:YES];
  _webView.backgroundColor = [UIColor clearColor];
  
    if ([currentView isEqualToString:@"Who is Teaching?"]) {
      self.navigationItem.title = kLangualString(@"Who is Teaching?");
      strin = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">Satya Sadhna is a blessing for humanity. It is an age-old practice which can be learnt under the guidance and direction of a GURU.  At present \"SHRI PUJYA SHRI JIN CHANDRA SURIJI MAHARAJSAHAB\" preaches and inspires everyone to move ahead on the path of SATYA SADHNA.</span></span></p>\n\n <p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">\"PARAM PUJYA GURUDEV SHRI PUJYAJI SHRI JIN CHANDRA SURIJI MAHARAJSAHAB\" is the present Acharya of KHATTERGACCHPATI in the lineage of the 24thTirthankar of Jain religion Lord Mahavir. The head of the KHATTERGACCHPATI is known as SHRI PUJYA JI who continues to teach this technique of SATYA SADHNA generationafter generation. In this tradition were born FOUR DADA GURUDEVS in between the 10th and 15th century there names were Shri Jin DuttSuriji, Manidhari Shri Jin Chandra Suriji, Shri JinKushal Suriji and Shri Jin Chandra Suriji. Shri Jin DuttSuriji named his successor as Manidhari Shri Jin Chandra Surji and from there on this tradition has been established where every 4th Acharya is named SHRI JIN CHANDRA SURIJI. The present Acharya SHRI JIN CHANDRA SURIJI is also a follower of this 1000 year old tradition.</span></span></p>\n\n <p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">ACHARYAJI himself along with his appointed teachers preach and spread Satya Sadhna not over in India but all across the globe.</span></span></p>";
      
      strhindi = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">सत्य साधना ध्यान मनुष्य जीवन के लिए वरदान है। यह एक पुरातन सम्पदा है। जिसे सद्गुरु के दिशा-निर्देशन में मार्ग निर्देशन में सिखाते हैं | सत्य साधना ध्यान को बड़े करुण चित्त से कुछ कदम अंगुली पकड़ कर चलना सिखाते हैं। मार्ग में आने वाली बाधाओं से परिचित करवाकर उसे आगे बढ़ने के लिए समय-समय पर प्रेरित करते हैं। वर्तमान में हमें बड़े सौभाग्य से गुरुदेव श्रीपूज्य श्री जिनचंद्र सूरिजी म.सा. सद्गुरु के रूप में मिले हैं जो दिशा-निर्देशन करने के लिए सदैव तत्पर रहते हैं। ऐसे सद्गुरु के सान्निध्य में हम भी अपने आप को सत्य साधना ध्यान के रंग में रंग लें।</span></span></p>\n\n <p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">परम पूज्य गुरुदेव जंगम युग प्रधान, वृहद् भट्टारक, खतरगचधिपति जैनाचार्य 1008 श्रीपूज्यजी श्री जिनचंद्र सूरिजी महाराज साहब जैन धर्म के 24 वें तीर्थंकर भगवान महावीर की परंपरा में खतरगचधिपति परम्परा के अनुगामी हैं। खतरगचधिपति परम्परा के प्रमुख को श्रीपूज्य जी के रूप में जाना जाता है । जिनका आशीर्वाद पीढ़ी दर पीढ़ी संचित रहता है। जिनके द्वारा पीढ़ी दर पीढ़ी साधना की सरिता बहायी जाती रही है ।</span></span></p>\n\n <p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">इस परंपरा में चार दादागुरुदेव हुए जो 10 से 15 वीं ईसवी के बीच अवतरित हुए, जिनके नाम हैं श्री जिनदत्त सूरिजी, मणिधारी श्री जिनचंद्र सूरिजी, श्री जिनकुशल सूरिजी और श्री जिनचंद्र सूरिजी। इससे पता चलता है, कि दो दादागुरुदेवों के नाम श्री जिनचंद्र सूरिजी थे। श्री जिनदत्त सूरिजी ने अपनी परंपरा का उत्तराधिकार मणिधारी श्री जिनचंद्र सूरिजी को सौंपा था। 1000 वर्षो से यह परंपरा वर्तमान तक अनवरत है। जिसमें हर चौथे आचार्य श्री जिनचंद्र सूरिजी रहते है। इसी परंपरामें वर्तमान आचार्य भी श्रीपूज्य श्री जिनचंद्र सूरिजी हैं ।</span></span></p>\n\n <p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">गुरुदेव स्वयं देश-विदेश में सत्य साधना सिखा रहे हैं और इनके द्वारा नियुक्त आचार्य और आचार्या इस कार्य में उनका सहयोग कर रहे है।</span></span></p>";
      
      if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
        [_webView loadHTMLString:strhindi baseURL:nil];
      } else {
        [_webView loadHTMLString:strin baseURL:nil];
      }
      
    } else if([currentView isEqualToString:@"SatyaSadhna for children"]) {
      self.navigationItem.title = kLangualString(@"SatyaSadhna for Children");
      
      strin = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">To brighten the future of our children we provide them with the best possible education, clothes, food and we continuously work towards making them happy fulfilling their desires. However even after giving so much efforts we find that the children are filled with jealousy, anger, hatred, indiscipline and some even suffer from depression.The children are always living in constant pressure, anxiety and stress. And then we wonder where did we go wrong?Apart from giving the children outside education it is very important to develop their mind to remain calm, balanced.</span></span></p>\n\n <p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">That’s what SATYA SADHNA does it helps the mind to become calm and face the challenges of the world withoutany stress or anxiety.The SATYA SADHNA children camps are usually from 1-3 days in which they are taught Swas Darshan Meditation. Any child in the age group 8-18 years can participate in these courses.</span></span></p>";
      
      strhindi = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">अपने बच्चों का भविष्य उज्ज्वल बनाने के लिए आप उनका पूरा खयाल रखते हैं। जैसे- अच्छी शिक्षा, बेहतर कपड़े, खाना, अपने बाल बच्चों को खुश रखने के लिए आप कोई कमी नहीं रखते, लेकिन यदि आप विचार करें तो आपको ध्यान में आएगा कि श्रेष्ठ प्रयास करने के बाद भी बालक-बालिकाएं अनिच्छा, ईर्ष्या, जलन, क्रोध आदि दुर्भावनाओं के शिकार हो जाते हैं। ऐसी स्थिति में वे कुंठित, उत्तेजित, बेचैन और जीवन के प्रति नकारात्मक हो जाते हैं। तो अपने बच्चे के लालन-पालन में आपसे कहाँ चूक हुई है?</span></span></p>\n\n <p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">जीवन के आरंभिक दौर से ही सत्य साधना सिखाने से बच्चों का आंतरिक विकास होने लगता है। बाहरी शिक्षा के साथ यदि वे भीतरी दुनिया की शिक्षा भी ग्रहण करें तो उनका जीवन संतुलित, संस्कारित और सुखी होने लगता है। सत्य साधना केंद्रों तथा स्कूलों में बच्चों को सत्य साधना सिखाने के लिए कार्यक्रम संचालित किए जाते हैं । सत्य साधना केन्द्रों पर एवं अन्य स्थानों पर बालक-बालिकाओं के लिए एक दिवसीय व तीन दिवसीय सत्य साधना के कोर्स लगाये जाते है। जहाँ उन्हें श्वास दर्शन की साधना सिखायी जाती है, जो सत्य साधना की प्रारंभिक शिक्षा है। ये कोर्सेज 6 से 18 वर्ष बालक-बालिकाओं के लिए कराए जाते हैं आयु वर्ग के</span></span></p>";
      
      if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
        [_webView loadHTMLString:strhindi baseURL:nil];
      } else {
        [_webView loadHTMLString:strin baseURL:nil];
      }
      
    } else if([currentView isEqualToString:@"Gypsy Courses"]) {
      self.navigationItem.title = kLangualString(@"Gypsy Courses");
      
      strin = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">On getting an invitation from different places and with the permission of SHRI PUJYAJI SHRI JIN CHANDRA SURIJI MAHARJSAHAB the assistant teachers go and conduct 10-day SATYA SADHNA Camp in various cities so that the locals of that place can also be benefited from it. Once thedate and the timings are finalised the information is published in the newsletter and the website so that peoplein the nearby places can also join in.</span></span></p>";
      
      strhindi = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">जिप्सी कोर्सेज (प्रवासी अभ्यास क्रम) : 10 दिवसीय सत्य साधना शिविरों एवं अन्य शिविरों के लिए विभिन्न स्थानों से आमंत्रण प्राप्त होते हैं। ऐसे आमंत्रणों पर विचार कर परम पूज्य गुरुदेव श्रीपूज्य श्री जिनचंद्र सूरि जी महाराज साहब की आज्ञा से शिविरों के संचालन के लिए टीचर्स विभिन्न स्थानों का प्रवास करते हैं। ताकि हर किसी को इस कल्याणकारी विद्या का लाभ मिल सके। सत्य साधना के लाभ का अनुभव ले चुके अनेक साधक-साधिकाएं इन शिविरों के आयोजन में सेवा देने के लिए आगे आते हैं। जब भी इन कोर्सेज का आयोजन किया जाता है, तो दिनांक और स्थान की जानकारी पूर्व में ही न्यूज-लेटर तथा वेबसाइट पर दे दी जाती है। ताकि उस स्थान में और उस स्थान के निकट रहने वाले लोगों को सत्य साधना का लाभ मिल सके ।</span></span></p>";
      
      if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
        [_webView loadHTMLString:strhindi baseURL:nil];
      } else {
        [_webView loadHTMLString:strin baseURL:nil];
      }
      
    } else if([currentView isEqualToString:@"One Day Course"]) {
      self.navigationItem.title = kLangualString(@"One Day Course");
      
      strin = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">One day course are regularly held at Satya Sadhna Kendraand other places. Those who have already done a 10-day course may participate in these courses. Anyone above the age of 18 can participate in this one day course. Participating in these one day courses helps in rejuvenating one self.</span></span></p>";
      
      strhindi = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">सत्य साधना केंद्रों और अन्य स्थानों पर इनका नियमित आयोजन किया जाता है, 10 दिन का अभ्यास क्रम कर चुके शिविरार्थियों और अन्य सभी व्यक्तियों जिनकी आयु 18 वर्ष से अधिक हैं, वे इस शिविर में भाग ले हैं एक दिवसीय शिविर करके साधक-साधिकाएं नई ऊर्जा प्राप्त करते हैं और अधिक उत्साह के साथ प्रतिदिन की साधना करने लगते हैं ।</span></span></p>";
      
      if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
        [_webView loadHTMLString:strhindi baseURL:nil];
      } else {
        [_webView loadHTMLString:strin baseURL:nil];
      }
      
    } else if([currentView isEqualToString:@"Introductory Session"]) {
      self.navigationItem.title = kLangualString(@"Introductory Session");
      strin = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">One hour introductory sessions of SatyaSadhna are regularly organised all over the world in which everyone can participate. These sessions provide an insight to Satya Sadhna as well as help everyone to start the practice of Satya Sadhna daily for 10-15 minutes.</span></span></p>";
      
      strhindi = @"<p style=\"text-align: justify;\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:18px\">सत्य साधना की शुरुआत लिए एक घंटे की परिचय सभाओं का आयोजन विभिन्न जगहों पर किया जाता है। जिससे व्यक्ति हर दिन सुबह और शाम अपने घर पर 10-15 मिनट का अभ्यास करते रहें और दस दिन के सत्य साधना शिविर को जल्दी से जल्दी कर लें।</span></span></p>";
      
      if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
        [_webView loadHTMLString:strhindi baseURL:nil];
      } else {
        [_webView loadHTMLString:strin baseURL:nil];
    }
  }
  _webView.opaque = NO;
  [self.view setBackgroundColor:kBgImage];
  self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
  if ([isFromView isEqualToString:@"satya"]) {
    self.addLeftBarBarBackButtonEnabled = YES;
  } else {
    self.addLeftBarMenuButtonEnabled = YES;
  }
  id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
  [tracker set:kGAIScreenName value:@"Introduction"];
  [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
  
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [activityIndicatorView stopAnimating];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  [alert show];
}

//MARK: Add Right Navigation Bar Button
- (void)setAddRightBarBarBackButtonEnabled:(BOOL)addRightBarBarBackButtonEnabled {
  //This is for add Right button
  if (addRightBarBarBackButtonEnabled) {
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(0, 0, 30, 90)];
    [btnBack setImage:[UIImage imageNamed:@"dashboardSlide"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(actionRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.rightBarButtonItem = barButton;
  } else {
    [self.navigationItem setHidesBackButton:YES];
  }
}

- (void)actionRightBarButton:(UIButton *)btn {
  
  if ([isFromView isEqualToString:@"satya"]) {
    [self.navigationController popToRootViewControllerAnimated:true];
  } else {
    UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
    [self.navigationController pushViewController:vc animated:YES];
  }
  
  
}
@end
