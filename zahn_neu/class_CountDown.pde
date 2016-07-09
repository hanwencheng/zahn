private class CountDown 
{
  private int _timeLeft;
  private int _lastTick;
  private boolean _paused;

  public void start(int amount) {
    _lastTick = millis() / 1000;
    _timeLeft = amount;
  }

  public boolean isPaused() {
    return _paused;
  }

  public void togglePause() {
    _paused = !_paused;
  }

  public boolean running() {
    return _timeLeft > 0;
  }

  public int timeLeft() {
    return _timeLeft;
  }

  public void tick() {
    int tick = millis() / 1000;
    if (!_paused) { // check if paused
      _timeLeft -= (tick - _lastTick);
    }
    _lastTick = tick;
  }
}