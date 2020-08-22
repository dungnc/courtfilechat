
import 'package:common/model/code_label.dart';

class DataFieldConfigCode extends CodeLabel {
  static final String ADVANCED_SEARCH_LOCATION_ALL_LOCATION = "AdvancedSearchLocationAllLocations";
  static final String DOCUMENT_DESCRIPTION = "DocumentDescription";
  static final String DOCUMENT_TYPE = "DocumentType";
  static final String FILING_EVENT_CASE_PARTIES = "FilingEventCaseParties";
  static final String FILING_FILING_ATTORNEY_VIEW = "FilingFilingAttorneyView";
  static final String FILING_FILING_DESCRIPTION = "FilingFilingDescription";
  static final String FILING_SERVICE_CHECK_BOX_INITIAL = "FilingServiceCheckBoxInitial";
  static final String FILING_SERVICE_CHECK_BOX_SUBSEQUENT = "FilingServiceCheckBoxSubsequent";
  static final String GLOBAL_ATTORNEY_NUMBER_VERIFY_BUTTON = "GlobalAttorneyNumberVerifyButton";
  static final String GLOBAL_PASSWORD = "GlobalPassword";
  static final String OPTIONAL_SERVICES_MULTIPLE_COPIES = "OptionalServicesMultipleCopies";
  static final String ORIGINAL_FILE_NAME = "OriginalFileName";
  static final String PARTY_ADD_ANOTHER_PARTY_BUTTON_SUBSEQUENT = "PartyAddAnotherPartyButtonSubsequent";
  static final String PUBLIC_SERVICE_CONTACT_SHOW_EMAIL ="PublicServiceContactShowEmail";
  static final String PUBLIC_SERVICE_CONTACT_SHOW_FREE_FORM_FIRM_NAME = "PublicServiceContactShowFreeFormFirmName";
  static final String SERVICE_CONTACT_EMAIL_ADDRESS = "ServiceContactEmailAddress";
  static final String SERVICE_CONTACT_IS_PUBLIC = "ServiceContactIsPublic";
  static final String SERVICE_CONTACT_STREET_ADDRESS= "ServiceContactStreetAddress";

  bool visible;
  bool required;
  String helpText;
  String validationMessage;
  String regularExpression;

}
