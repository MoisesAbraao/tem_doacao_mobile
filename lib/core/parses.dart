import '../models/donation_status.dart';

DonationStatus parseDonationStatusStringToDonationStatus(String status) {
  switch(status) {
    case 'finalized':
      return DonationStatus.finalized;
    case 'canceled':
      return DonationStatus.canceled;
    case 'stopped':
      return DonationStatus.stopped;
    case 'started':
    default:
      return DonationStatus.started;
  }
}

String parseDonationStatusToDonationStatusString(DonationStatus status) {
  switch(status) {
    case DonationStatus.finalized:
      return 'finalized';
    case DonationStatus.canceled:
      return 'canceled';
    case DonationStatus.stopped:
      return 'stopped';
    case DonationStatus.started:
    default:
      return 'started';
  }
}
