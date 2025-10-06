# VPN Auth Failures After Password Change

**Symptoms:** VPN prompts for credentials repeatedly after changing your account password.

**Fix:**
1) Remove old credentials from **Keychain Access** (search for your VPN server name).
2) Re‑enter credentials with the new password.
3) If your VPN uses a profile, re-import the profile from IT.
4) Verify network reachability (ping gateway, DNS). See diagnostics script in `/scripts/mac`.
