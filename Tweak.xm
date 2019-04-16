@interface MMLbsContactInfo : NSObject
@property(nonatomic) int sex; 
@property(retain, nonatomic) NSString *city; 
@property(retain, nonatomic) NSString *country; 
@property(retain, nonatomic) NSString *nickName;
@property(retain, nonatomic) NSString *province;
@property(retain, nonatomic) NSString *m_nsAlias;
@property(retain, nonatomic) NSString *m_nsHeadImgUrl;
@property(retain, nonatomic) NSString *m_nsHeadHDImgUrl; 
@property(retain, nonatomic) NSString *userName; 
@end
@interface LbsContactInfoList : NSObject
@property(retain, nonatomic) NSMutableArray *lbsContactList;
@end
@interface PeopleNearByListViewController : UIViewController
@property(retain, nonatomic) LbsContactInfoList *lbsContactList;
- (void)saveNearbyToUserDefault;
- (NSString *)isStrNil:(NSString *)str;
@end

%hook PeopleNearByListViewController

%new
- (NSString *)isStrNil:(NSString *)str{
    if (str && str.length > 0)
    {
        return str;
    }else return @"";
}

%new
- (void)saveNearbyToUserDefault{
	LbsContactInfoList *infoList = self.lbsContactList;
    NSArray *array = infoList.lbsContactList;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:10];
    for(int i = 0; i < array.count; i++){	
        MMLbsContactInfo *info = [array objectAtIndex:i];
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:10];
        [mutableDictionary setObject:[NSString stringWithFormat:@"%d", info.sex] forKey:@"sex"];
        [mutableDictionary setObject:[self isStrNil:info.city] forKey:@"city"];
        [mutableDictionary setObject:[self isStrNil:info.country] forKey:@"country"];
      	[mutableDictionary setObject:[self isStrNil:info.nickName] forKey:@"nickName"];
      	[mutableDictionary setObject:[self isStrNil:info.province] forKey:@"province"];
      	[mutableDictionary setObject:[self isStrNil:info.m_nsAlias] forKey:@"m_nsAlias"];
    	[mutableDictionary setObject:[self isStrNil:info.m_nsHeadImgUrl] forKey:@"m_nsHeadImgUrl"];
    	[mutableDictionary setObject:[self isStrNil:info.m_nsHeadHDImgUrl] forKey:@"m_nsHeadHDImgUrl"];
  		[mutableDictionary setObject:[self isStrNil:info.userName] forKey:@"userName"];
        [mutableArray addObject:mutableDictionary];
    }
    [userDefault setObject:mutableArray forKey:@"nearby_people_key"];
    [userDefault synchronize];
}



- (void)reloadWithLbsContactInfoList:(id)arg1{
    %orig;
    [self saveNearbyToUserDefault];
}

%end
