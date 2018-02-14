## MVVM-tvOS-Demo
MVVM Pattern Sample tvOS App with UI and Unit tests in Swift

This is an example project to demonstrate the MVVM (Model-View-ViewModel) architecture with UI and Unit tests.

## SettingsViewModelProtocol

```swift
protocol SettingsViewModelProtocol {
    
    var isFakeData: Bool { get set }
    var kidsCountLimit: Int { get set }

    // MARK: - initializers

    init(userProfile: UserProfile?, kidAccounts: [KidAccount]?, settingsCallback: SettingsCallbcak?)
    
    // MARK: - Methods

    func setUserProfile(_ userProfile: UserProfile?)
    func getUserProfile() -> UserProfilePresentable?
    func setKidAccounts(_ kidsAccounts: [KidAccount]?)
    func getKidsAccounts() -> [KidAccountPresentable]
    
    func save(onSuccess:@escaping ()->(), onError:@escaping (_ error:Error)->())
    func getNextViewControllerViewModel(index: Int, type: SettingsSectionType) -> SettingsDetailViewModelProtocol
}
```

## UI Test
Test that the result is as expected.

```swift
func testTapMenuButton_withoutSigningIn_doGoToLanding() {
      let app = XCUIApplication()
      XCUIRemote.shared().press(.down)

      let signInWithPlayformButton = app.buttons["Sign in with Playform"]
      XCTAssert(signInWithPlayformButton.hasFocus, "The app should focus on the 'Sign in with Playform' button")
      XCUIRemote.shared().press(.select)

      // Waiting for the activation view to appear
      wait(for: 1)
      XCTAssertFalse(signInWithPlayformButton.exists, "The 'Sign in with Playform' button does exist")

      let getANewCodeButton = app.buttons["Get a New Code"]
      XCTAssertTrue(getANewCodeButton.exists, "The 'Get a New Code' button doesn't exist")
      XCUIRemote.shared().press(.menu)

      // Waiting for the landing view to appear
      wait(for: 1)
      XCTAssertTrue(signInWithPlayformButton.exists, "The 'Sign in with Playform' button doesn't exist")
  }
```

## Unit Test
Test that the result is as expected.

```swift
func testGetKidAccounts_useFakeData_returnSelena() {
    // 1. Arrange
    var kidsAccounts: [KidAccountPresentable]? = nil

    // 2. Act
    kidsAccounts = self.viewModel?.getKidsAccounts()

    // 3. Assert
    XCTAssertNotNil(kidsAccounts, "The kids accounts shouldn't nil.")
    XCTAssertEqual(kidsAccounts?.count, 3, "The kids accounts count should be 3")
    XCTAssertEqual(kidsAccounts?[0].kidNickName, "Selena", "The kid nickname should be Selena.")
}
```
