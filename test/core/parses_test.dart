
import 'package:flutter_test/flutter_test.dart';
import 'package:tem_doacao_mobile/core/parses.dart';
import 'package:tem_doacao_mobile/models/donation_status.dart';

void main() {
  group('parseDonationStatusStringToDonationStatus', () {
    test('should parse when "started"', () {
      final donationStatus = parseDonationStatusStringToDonationStatus('started');

      expect(donationStatus, DonationStatus.started);
    });

    test('should parse when "finalized"', () {
      final donationStatus = parseDonationStatusStringToDonationStatus('finalized');

      expect(donationStatus, DonationStatus.finalized);
    });

    test('should parse when "canceled"', () {
      final donationStatus = parseDonationStatusStringToDonationStatus('canceled');

      expect(donationStatus, DonationStatus.canceled);
    });

    test('should parse when "stopped"', () {
      final donationStatus = parseDonationStatusStringToDonationStatus('stopped');

      expect(donationStatus, DonationStatus.stopped);
    });

    test('should parse to "started" when not found', () {
      final donationStatus = parseDonationStatusStringToDonationStatus('nonexistent');

      expect(donationStatus, DonationStatus.started);
    });
  });

  group('parseDonationStatusToDonationStatusString', () {
    test('should parse when DonationStatus.started', () {
      final donationStatus = parseDonationStatusToDonationStatusString(DonationStatus.started);

      expect(donationStatus, 'started');
    });

    test('should parse when DonationStatus.finalized', () {
      final donationStatus = parseDonationStatusToDonationStatusString(DonationStatus.finalized);

      expect(donationStatus, 'finalized');
    });

    test('should parse when DonationStatus.canceled', () {
      final donationStatus = parseDonationStatusToDonationStatusString(DonationStatus.canceled);

      expect(donationStatus, 'canceled');
    });

    test('should parse when DonationStatus.stopped', () {
      final donationStatus = parseDonationStatusToDonationStatusString(DonationStatus.stopped);

      expect(donationStatus, 'stopped');
    });

    test('should parse to "started" when not found', () {
      final donationStatus = parseDonationStatusToDonationStatusString(null);

      expect(donationStatus, 'started');
    });
  });
}
