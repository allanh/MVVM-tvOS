/*
 * Copyright (C) 2017 Mattel, Inc. All rights reserved.
 *
 * All information and code contained herein is the property of
 * Mattel, Inc.
 *
 * Any unauthorized use, storage, duplication, and redistribution of
 * this material without written permission from Mattel, Inc. is
 * strictly prohibited.
 *
 * UserProfilePresentable.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/22.
 */

import Foundation
import PlayformSDK_TV

// MARK: - User Profile Phone Presentable
/// This class contains general user's phone information.
protocol UserProfilePhonePresentable {
    
    // MARK: - Properties
    /// Phones
    var userPhone: UserProfilePhone? { get set }
    
    /// Phone Type
    var phoneType: String? { get }
    
    /// Phone Number
    var phoneNumber: String? { get }
    
    /// This boolean value flags the current phone number as the primary phone number or not.
    var isPrimaryPhone: Bool? { get }
    
    // MARK: - initializers
    init(phone: UserProfilePhone?)
}

// MARK: - User Profile Email Presentable
/// This class contains general user's email information.
protocol UserProfileEmailPresentable {
    
    // MARK: - Properties
    /// Phones
    var userEmail: UserProfileEmail? { get set }
    
    /// Email Type
    var emailType: String? { get }
    
    /// Email Address
    var email: String? { get }
    
    /// This boolean value flags the current email address as the primary email address or not.
    var isPrimaryEmail: Bool? { get }
    
    /// This boolean value flags the current email address is verified or not.
    var isVerifiedEmail: Bool? { get }
   
    // MARK: - initializers
    init(email: UserProfileEmail?)
}

// MARK: - User Profile Address Presentable
/// This class contains the user address.
protocol UserProfileAddressPresentable {
    
    // MARK: - Properites
    /// Address
    var userAddress: UserProfileAddress? { get set }
    
    /// Address type
    var addressType: String? { get }
    
    /// First address line
    var firstAddressLine: String? { get }
    
    /// Second address line
    var secondAddressLine: String? { get }
    
    /// City
    var city: String? { get }
    
    /// State
    var state: String? { get }
    
    /// Zipcode
    var zipCode: String? { get }
    
    /// Country
    var country: String? { get }
    
    /// This boolean value flags the current address as the primary address or not.
    var isPrimaryAddress: Bool? { get }
    
    // MARK: - initializers
    init(address: UserProfileAddress? )
}

// MARK: - User Profile Presentable
/// This class contains general user information.
protocol UserProfilePresentable {
    
    // MARK: - Properties
    /// UserProfile
    var userProfile: UserProfile? { get set }

    /// Nickname
    var nickName: String? { get }
    
    /// First name
    var firstName: String? { get set }
    
    /// Last name
    var lastName: String? { get set }
    
    /// Middle name
    var middleName: String? { get }
    
    /// Avatar (URL)
    var avatarUrl: String? { get }
    
    /// List of phone numbers
    var phones: [UserProfilePhonePresentable]? { get }
    
    /// Primary phone number
    var primaryPhone: UserProfilePhonePresentable? { get }
    
    /// List of email addresses
    var emails: [UserProfileEmailPresentable]? { get }
    
    /// Primary email addresses
    var primaryEmail: UserProfileEmailPresentable? { get }

    /// List of addresses
    var addresses: [UserProfileAddressPresentable]? { get }
    
    /// Primary addresses
    var primaryAddresses: UserProfileAddressPresentable? { get }

    /// Country
    var country: String? { get }
    
    /// Language
    var language: String? { get }
    
    /// Time zone
    var timeZone: String? { get }
    
    /// Gender
    var gender: String? { get set }
    
    /// Birth Day
    var dayOfBirth: Int? { get set }
    
    /// Birth Month
    var monthOfBirth: Int? { get set }
    
    /// Birth Year
    var yearOfBirth: Int? { get set }
    
    // MARK: - initializers
    init(userProfile: UserProfile?)
}


// MARK: - Property default values

extension UserProfilePhonePresentable {
    var phoneType: String? { return self.userPhone?.phoneType }
    var phoneNumber: String? { return self.userPhone?.phoneNumber }
    var isPrimaryPhone: Bool? { return self.userPhone?.isPrimary }
}

extension UserProfileEmailPresentable {
    var emailType: String? { return self.userEmail?.emailType }
    var email: String? { return self.userEmail?.email }
    var isPrimaryEmail: Bool? { return self.userEmail?.isPrimary }
    var isVerifiedEmail: Bool? { return self.userEmail?.verified }
}

extension UserProfileAddressPresentable {
    var addressType: String? { return self.userAddress?.addressType }
    var firstAddressLine: String? { return self.userAddress?.firstAddressLine }
    var secondAddressLine: String? { return self.userAddress?.secondAddressLine }
    var city: String? { return self.userAddress?.city }
    var state: String? { return self.userAddress?.state }
    var zipCode: String? { return self.userAddress?.zipCode }
    var country: String? { return self.userAddress?.country }
    var isPrimaryAddress: Bool? { return self.userAddress?.isPrimary }
}

extension UserProfilePresentable {
    var nickName: String? { return self.userProfile?.nickName }
    var middleName: String? { return self.userProfile?.middleName }
    var avatarUrl: String? { return self.userProfile?.avatarUrl }
    var country: String? { return self.userProfile?.country }
    var language: String? { return self.userProfile?.language }
    var timeZone: String? { return self.userProfile?.timeZone }
    
    var phones: [UserProfilePhonePresentable]? {
        guard let phones = self.userProfile?.phones else {
            return nil
        }
        
        var myPhones: [UserProfilePhonePresentable] = []
        for phone in phones {
            myPhones.append(MyUserProfilePhone(phone: phone))
        }
        return myPhones
    }
    
    var primaryPhone: UserProfilePhonePresentable? {
        return self.phones?.find({$0.isPrimaryPhone == true})
    }
    
    /// List of email addresses
    var emails: [UserProfileEmailPresentable]? {
        guard let emails = self.userProfile?.emails else {
            return nil
        }
        
        var myEmails: [UserProfileEmailPresentable] = []
        for email in emails {
            myEmails.append(MyUserProfileEmail(email: email))
        }
        return myEmails
    }
    
    var primaryEmail: UserProfileEmailPresentable? {
        return self.emails?.find({$0.isPrimaryEmail == true})
    }
    
    /// List of addresses
    var addresses: [UserProfileAddressPresentable]? {
        guard let addresses = self.userProfile?.addresses else {
            return nil
        }
        
        var myAddresses: [UserProfileAddressPresentable] = []
        for address in addresses {
            myAddresses.append(MyUserProfileAddress(address: address))
        }
        return myAddresses
    }
    
    var primaryAddresses: UserProfileAddressPresentable? {
        return self.addresses?.find({$0.isPrimaryAddress == true})
    }
}


// MARK: - Cusomize UserProfile

struct MyUserProfilePhone: UserProfilePhonePresentable {
    var userPhone: UserProfilePhone?
    
    init(phone: UserProfilePhone?) {
        self.userPhone = phone
    }
}

struct MyUserProfileEmail: UserProfileEmailPresentable {
    var userEmail: UserProfileEmail?
    
    init(email: UserProfileEmail?) {
        self.userEmail = email
    }
}

struct MyUserProfileAddress: UserProfileAddressPresentable {
    var userAddress: UserProfileAddress?
    
    init(address: UserProfileAddress?) {
        self.userAddress = address
    }
}

struct MyUserProfile: UserProfilePresentable {
    
    var userProfile: UserProfile?

    /// Birth Year
    var yearOfBirth: Int? {
        get {
            return self.userProfile?.yearOfBirth
        }
        set {
            self.userProfile?.yearOfBirth = newValue ?? 0
        }
    }

    /// Birth Month
    var monthOfBirth: Int? {
        get {
            return self.userProfile?.monthOfBirth
        }
        set {
            self.userProfile?.monthOfBirth = newValue ?? 0
        }
    }

    /// Birth Day
    var dayOfBirth: Int? {
        get {
            return self.userProfile?.dayOfBirth
        }
        set {
            self.userProfile?.dayOfBirth = newValue ?? 0
        }
    }

    /// Gender
    var gender: String? {
        get {
            return self.userProfile?.gender
        }
        set {
            self.userProfile?.gender = newValue
        }
    }

    /// Last name
    var lastName: String? {
        get {
            return self.userProfile?.lastName
        }
        set {
            self.userProfile?.lastName = newValue
        }
    }

    /// First name
    var firstName: String? {
        get {
            return self.userProfile?.firstName
        }
        set {
            self.userProfile?.firstName = newValue
        }
    }
    
    // MARK: - initializers
    
    init(userProfile: UserProfile?) {
        if userProfile != nil {
            self.userProfile = userProfile
        } else {
            self.userProfile = UserProfile()
        }
    }
}


