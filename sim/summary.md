# [FAILED] Regression Summary Report

## 1. Metrics

- **Start Time:** 11.06.2026 20:15:02
- **End Time:** 11.06.2026 20:23:41
- **Git Commit:** `42dfb73`
- **Total Tests Run:** 27
- **Passed:** 12
- **Failed:** 15
- **Pass Rate:** 44.4%

## 2. Test List Summary

| # | Test Name | Group | Seed | Start Time | Status | Bug Report / Details |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | `one_coin_test` | user_tests | 278859 | 11.06.2026_20:15:03 | *PASSED* | — |
| 2 | `few_coin_test` | user_tests | 820396 | 11.06.2026_20:15:24 | *PASSED* | — |
| 3 | `dollars_test` | user_tests | 222664 | 11.06.2026_20:15:44 | *PASSED* | — |
| 4 | `euros_test` | user_tests | 320193 | 11.06.2026_20:16:02 | *PASSED* | — |
| 5 | `random_client_without_change_test` | user_tests | 183164 | 11.06.2026_20:16:21 | *PASSED* | — |
| 6 | `client_session_without_errors_test` | user_tests | 49724 | 11.06.2026_20:16:39 | ***FAILED*** | [View Bug Report](bugs/bug_client_session_without_errors_test_seed_49724.md) |
| 7 | `client_session_without_errors_test` | user_tests | 834578 | 11.06.2026_20:16:58 | ***FAILED*** | [View Bug Report](bugs/bug_client_session_without_errors_test_seed_834578.md) |
| 8 | `check_after_reset_test` | register_tests | 740314 | 11.06.2026_20:17:16 | ***FAILED*** | [View Bug Report](bugs/bug_check_after_reset_test_seed_740314.md) |
| 9 | `check_write_test` | register_tests | 760907 | 11.06.2026_20:17:35 | *PASSED* | — |
| 10 | `check_read_test` | register_tests | 318928 | 11.06.2026_20:17:54 | ***FAILED*** | [View Bug Report](bugs/bug_check_read_test_seed_318928.md) |
| 11 | `check_alarm_test` | emergency_tests | 682343 | 11.06.2026_20:18:13 | *PASSED* | — |
| 12 | `client_session_after_change_price_test` | integration_tests | 837525 | 11.06.2026_20:18:31 | *PASSED* | — |
| 13 | `client_session_after_change_discount_test` | integration_tests | 106891 | 11.06.2026_20:18:52 | ***FAILED*** | [View Bug Report](bugs/bug_client_session_after_change_discount_test_seed_106891.md) |
| 14 | `buy_for_dollars_after_change_exchange_rate_test` | integration_tests | 632256 | 11.06.2026_20:19:16 | *PASSED* | — |
| 15 | `buy_for_euros_after_change_exchange_rate_test` | integration_tests | 338788 | 11.06.2026_20:19:36 | ***FAILED*** | [View Bug Report](bugs/bug_buy_for_euros_after_change_exchange_rate_test_seed_338788.md) |
| 16 | `client_session_after_change_exchange_rate_test` | integration_tests | 743288 | 11.06.2026_20:19:56 | ***FAILED*** | [View Bug Report](bugs/bug_client_session_after_change_exchange_rate_test_seed_743288.md) |
| 17 | `client_session_after_change_all_registers_test` | integration_tests | 583590 | 11.06.2026_20:20:14 | ***FAILED*** | [View Bug Report](bugs/bug_client_session_after_change_all_registers_test_seed_583590.md) |
| 18 | `client_session_with_emergency_test` | integration_tests | 23019 | 11.06.2026_20:20:33 | ***FAILED*** | [View Bug Report](bugs/bug_client_session_with_emergency_test_seed_23019.md) |
| 19 | `write_registers_with_emergency_test` | integration_tests | 959192 | 11.06.2026_20:20:52 | ***FAILED*** | [View Bug Report](bugs/bug_write_registers_with_emergency_test_seed_959192.md) |
| 20 | `invalid_client_id_test` | errors_tests | 380832 | 11.06.2026_20:21:11 | ***FAILED*** | [View Bug Report](bugs/bug_invalid_client_id_test_seed_380832.md) |
| 21 | `invalid_coin_denomination_test` | errors_tests | 50620 | 11.06.2026_20:21:29 | *PASSED* | — |
| 22 | `insufficient_funds_test` | errors_tests | 665129 | 11.06.2026_20:21:48 | ***FAILED*** | [View Bug Report](bugs/bug_insufficient_funds_test_seed_665129.md) |
| 23 | `coin_timeout_refund_test` | errors_tests | 989556 | 11.06.2026_20:22:07 | ***FAILED*** | [View Bug Report](bugs/bug_coin_timeout_refund_test_seed_989556.md) |
| 24 | `confirm_timeout_refund_test` | errors_tests | 638497 | 11.06.2026_20:22:26 | ***FAILED*** | [View Bug Report](bugs/bug_confirm_timeout_refund_test_seed_638497.md) |
| 25 | `unauthorized_write_register_test` | errors_tests | 12011 | 11.06.2026_20:22:44 | ***FAILED*** | [View Bug Report](bugs/bug_unauthorized_write_register_test_seed_12011.md) |
| 26 | `write_registers_with_invalid_password_test` | errors_tests | 503087 | 11.06.2026_20:23:03 | *PASSED* | — |
| 27 | `invalid_password_change_test` | errors_tests | 766180 | 11.06.2026_20:23:22 | *PASSED* | — |
