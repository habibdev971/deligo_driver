class ExpiryResult {
  final Duration difference;
  final bool isExpired;

  ExpiryResult({required this.difference, required this.isExpired});
}

ExpiryResult checkExpiry(DateTime inputTime) {
  final now = DateTime.now();

  // Check if date is today
  final isSameDate = inputTime.year == now.year &&
      inputTime.month == now.month &&
      inputTime.day == now.day;

  // If not same date = auto expire
  if (!isSameDate) {
    return ExpiryResult(
      difference: now.difference(inputTime),
      isExpired: true,
    );
  }

  // Expiry duration: 2 minutes 30 seconds
  const expiryDuration = Duration(minutes: 2, seconds: 30);

  final diff = now.difference(inputTime);
  final isExpired = diff >= expiryDuration;

  return ExpiryResult(
    difference: diff,
    isExpired: isExpired,
  );
}
