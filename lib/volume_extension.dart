extension VolumeExtension on int {
  int stabilized() {
    if (this > 100) return 100;
    if (this < 0) return 0;
    return this;
  }
}
