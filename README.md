# USBenchmark A.I.

Part of the **Albion Benchmark Desk** — a parallel scientific baseline for the
original Albion Trading Desk. USBenchmark trades the S&P 500 on **pure Lancelot
signals with no AI overlay**, so its P&L can be compared like-for-like against the
original USTrader.

- **Port:** 5024 · **Instrument:** S&P 500 (US500, Capital.com) · **Balance:** £1,000
- **Template:** USTrader v1.2.3 · **Paper trading only** · **Session:** 14:30–21:00 UTC weekdays

> **BIDIRECTIONAL — unlike the original.** USTrader is LONG_ONLY, but that was an
> Arthur/Morgan decision (enforced in `main_ustrader`, not in Lancelot). With the AI
> stripped, USBenchmark trades both ways: the 3-timeframe SSL agreement sets the
> direction and the switch flips it, so it can **SHORT the S&P 500** when Daily+1h+5m
> all agree BEAR. This makes it a genuinely different beast from its counterpart.

## Decision engine (the whole thing)

Every 5-minute candle:

1. **Lancelot pre-checks** must all pass — identical to USTrader (`pre_checks_us`, copied verbatim, confirmed pure — it validates whatever direction it's given, including SHORT).
2. **3-timeframe SSL agreement** — Daily + 1h + 5m SSL must all point the same way. That is the direction signal.
3. **Direction switch** decides execution:
   - `WITH` — trade the SSL direction.
   - `AGAINST` — trade the opposite (contrarian). Lancelot always validates the *signal* direction; only the executed direction flips.

Exits are pure risk management: **30pt trailing stop / 45pt take profit / Profit Protection Ladder (Variant 2)** — via Stanley's `monitor_trade()`.

**Stripped vs USTrader:** no Arthur (AI), no Morgan (confidence), no Guinevere (news), no phantom logging, no confidence thresholds, **no LONG_ONLY restriction**.

Parameters: 0.6pt spread, bidirectional, switch default **WITH**. P&L uses the strategy's default GBPUSD (1.27).

## The direction switch (WITH / AGAINST)
One switch, **live reload** — re-read from `logs/direction_switch.json` every tick; flip from the dashboard or BenchmarkRoundTable with **no restart**. Default WITH; persists; atomic write.

## Running
```
python dashboard_usbenchmark.py     # port 5024 (switch + status)
python watchdog_usbenchmark.py      # supervises main_usbenchmark.py
```

Session phases: PRE_MARKET / US_OPEN / OPEN / CLOSED. Appears automatically on **BenchmarkRoundTable** (port 5030) once running.

All times UTC.
