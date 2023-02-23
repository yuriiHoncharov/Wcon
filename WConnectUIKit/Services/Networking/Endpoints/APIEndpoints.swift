//
//  APIEndpoints.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import Foundation

enum ApiEnvironment: String, Equatable, CaseIterable, Codable {
    case development = "https://backend-dev.wconnect.lampawork.com"
    case production = "https://backend.wconnect.work"
    case preproduction = "https://backend-preprod.wconnect.lampawork.com"
}

struct APIEndpoints {
    
//    static func environment() -> ApiEnvironment {
//        #if DEBUG
//            if let envStr = SecureStorage().load(with: SecureStorageKeys.kEnvironment, type: String.self),
//               let environment = ApiEnvironment.init(rawValue: envStr) {
//                return environment
//            }
//            return .development
//        #else
//            return .production
//        #endif
//    }

    private static let environment = ApiEnvironment.development
    private static let apiVersion = "/v1"
    private static func baseURL() -> String { return environment.rawValue + "/api" + apiVersion }
    
    struct Auth {
        static func login() -> String { return "\(baseURL())/auth/login" }
        static func logout() -> String { return "\(baseURL())/auth/logout" }
        static func emailVerify() -> String { return "\(baseURL())/auth/email-verify" }
        static func checkEmailCode() -> String { return "\(baseURL())/auth/check-email-code" }
        static func phoneVerify() -> String { return "\(baseURL())/auth/phone-verify" }
        static func checkPhoneCode() -> String { return "\(baseURL())/auth/check-phone-code" }
        static func forgotPassword() -> String { return "\(baseURL())/auth/forgot-password" }
        static func oauth() -> String { return "\(baseURL())/auth/oauth" }
        static func oauthConnect() -> String { return "\(baseURL())/auth/oauth/connect" }
        static func oauthRegistration() -> String { return "\(baseURL())/auth/registration/oauth" }
        static func resetPassword() -> String { return "\(baseURL())/auth/reset-password" }
        static func registrationCustomer() -> String { return "\(baseURL())/auth/registration/customer" }
        static func registrationSpecialist() -> String { return "\(baseURL())/auth/registration/specialist" }
        static func refreshToken() -> String { return "\(baseURL())/auth/refresh-token" }
    }
    
    struct Blog {
        static func search() -> String { return "\(baseURL())/blog/search" }
        static func create() -> String { return "\(baseURL())/blog" }
        static func blogId() -> String { return "\(baseURL())/blog/%@" }
    }
    
    struct Category {
        static func category() -> String { return "\(baseURL())/category" }
        static func subcategory() -> String { return "\(baseURL())/category/subcategory" }
        static func clarification() -> String { return "\(baseURL())/category/clarification" }
    }
    
    struct Country {
        static func cities() -> String { return "\(baseURL())/country/cities" }
        static func districts() -> String { return "\(baseURL())/country/city/districts" }
    }
    
    struct Customer {
        static func customer() -> String { return "\(baseURL())/customer" }
        static func customerId() -> String { return "\(baseURL())/customer/%@" }
        static func customerFavourites() -> String { return "\(baseURL())/customer/favourites" }
    }
    
    struct Notification {
        static func notification() -> String { return "\(baseURL())/notification/list" }
            static func updateReadStatus() -> String { return "\(baseURL())/notification/%@" }
            static func deleteNotification() -> String { return "\(baseURL())/notification/%@" }
    }
    
    struct Order {
        static func order() -> String { return "\(baseURL())/order" }
        static func createTask() -> String { return "\(baseURL())/order/%@/task" }
        static func confirmTask() -> String { return "\(baseURL())/order/%@/tasks/%@/confirm" }
        static func completeTask() -> String { return "\(baseURL())/order/%@/tasks/%@/complete" }
        static func cancelTask() -> String { return "\(baseURL())/order/%@/tasks/%@/cancel" }
        static func fixPrice() -> String { return "\(baseURL())/order/%@/tasks/%@/fix-price" }
        static func search() -> String { return "\(baseURL())/order/search" }
        static func deleteOrder() -> String { return "\(baseURL())/order/%@" }
        static func orderWithId() -> String { return "\(baseURL())/order/%@" }
        static func reserveFunds() -> String { return "\(baseURL())/order/%@/tasks/%@/reserve-funds" }
        static func orderForFavourites() -> String { return "\(baseURL())/order/for-favourites" }
        static func handleTaskTimer() -> String { return "\(baseURL())/order/%@/tasks/%@/timer" }
        static func additionalPriceProposal() -> String { return "\(baseURL())/order/%@/tasks/%@/add-price" }
        static func deleteOrderImage() -> String { return "\(baseURL())/order/%@/images/%@" }
        
    }
    
    struct Service {
        static func service() -> String { return "\(baseURL())/service" }
        static func serviceWithId() -> String { return "\(baseURL())/service/%@" }
        static func search() -> String { return "\(baseURL())/service/search" }
        static func anonSearch() -> String { return "\(baseURL())/service/anon-search"}
        static func deleteServiceImage() -> String { return "\(baseURL())/service/%@/images/%@" }

    }
    
    struct Specialist {
        static func specialist() -> String { return "\(baseURL())/specialist" }
        static func specialistInfo() -> String { return "\(baseURL())/specialist/%@" }
        static func specialistList() -> String { return "\(baseURL())/specialist/list" }
        static func specialistFavourites() -> String { return "\(baseURL())/specialist/favourites" }
    }
    
    struct Payment {
        static func createStripeAccount() -> String { return "\(baseURL())/payments/account" }
        static func createIyzicoAccount() -> String { return "\(baseURL())/payments/iyizico/account" }
    }
    
    struct PhoneCountryCode {
        static func countryCodes() -> String { return "\(baseURL())/country-codes" }
    }
    
    struct User {
        static func uploadAvatar() -> String { return "\(baseURL())/user/avatar" }
        static func getUserMe() -> String { return "\(baseURL())/user/me" }
        static func deleteAccount() -> String { return "\(baseURL())/user/me" }
        static func addFavorites() -> String { return "\(baseURL())/user/add-remove-favorites" }
        static func getDefaultAvatars() -> String { return "\(baseURL())/static-paths" }
    }
    
    struct Chat {
        static func base() -> String { return "\(baseURL())/chats" }
        static func disableChat() -> String { return "\(baseURL())/chats/%@/disable" }
        static func uploadMedia() -> String { return "\(baseURL())/chats/%@/upload" }
    }
    
    struct Feedback {
        static func createFeedback() -> String { return "\(baseURL())/feedback/task/%@" }
    }
    
    struct DefaultSettings {
        static func getDefaultSettings() -> String { return "\(baseURL())/default-settings/public" }
    }
    
    struct Socket {
        static func socketAddress() -> String { return "\(baseURL())/socket.io" }
    }
    struct PromotionBuyHistory {
        static func getPromotion() -> String { return "\(baseURL())/promotion-buy-history/" }
        static func deletePromotion() -> String { return "\(baseURL())/promotion-buy-history/disable-promotion/%@" }
        static func activatePromotion() -> String { return "\(baseURL())/promotion-buy-history/activate-promotion/%@" }
    }
    
    struct Complaint {
        static func createComplaints() -> String { return "\(baseURL())/complaint" }
        static func getComplaintsType() -> String { return "\(baseURL())/complaint/type/list" }
    }
    
    struct PromotionType {
        static func getPromotions() -> String { return "\(baseURL())/promotion-types" }
        static func reserveFunds() -> String { return "\(baseURL())/promotion-types/buy/%@" }
    }
    
    struct FAQ {
        static func getAllFAQ() -> String { return "\(baseURL())/faq/" }
        static func getFAQ() -> String { return "\(baseURL())/faq/%@" }
    }
    
    struct Verifications {
        static func getPhoneCode() -> String { return "\(baseURL())/verifications/code-for-phone/%@" }
        static func verifyPhone() -> String { return "\(baseURL())/verifications/verify-phone/" }
        static func getEmailCode() -> String { return "\(baseURL())/verifications/code-for-email/%@" }
        static func verifyEmail() -> String { return "\(baseURL())/verifications/verify-email/"}
    }
    
    struct Question {
        static func question() -> String { return "\(baseURL())/question/" }
        static func deactivateQuestion() -> String { return "\(baseURL())/question/deactivate/%@" }
    }
    
    struct Balance {
        static func balanceName() -> String { return "\(baseURL())/balance/balance-user" }
        static func balance() -> String { return "\(baseURL())/balance/detail-balance-user" }
        static func allBalance() -> String { return "\(baseURL())/balance/full-detail-balance-user" }
        static func historyBalance() -> String { return "\(baseURL())/balance/history-detail-balance-user" }
        static func initializeSessionPay() -> String { return "\(baseURL())/balance/initialize-session-pay" }
        static func checkSessionPayAddMoney() -> String { return "\(baseURL())/balance/check-session-pay-add-money-to-balance" }
        static func withdrawalSession() -> String { return "\(baseURL())/balance/withdrawal-money" }
        static func listInvoices() -> String { return "\(baseURL())/balance/print-list-invoices" }
        static func getInvoices() -> String { return "\(baseURL())/balance/print-pdf-invoice" }
    }
    
    struct Schemes {
        static let baseUrl = "byWconnectApp:%@?index=1"
        
        enum CallbackURL: String {
            case balanceUpdatedForAllCard = "balance/full-detail-balance-user"
            case createStripeAccount = "payments/account"
            case createIyzicoAccount = "payments/iyizico/account"
            case updateBalance = "payments/account/balance"
            case reserveFundsPromotion = "promotion-types/buy"
            
            var url: String {
                return String(format: APIEndpoints.Schemes.baseUrl, self.rawValue)
            }
        }
    }
}
