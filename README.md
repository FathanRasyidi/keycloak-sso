# Keycloak SSO CSP and Redirection Fix

This repository contains a custom Keycloak theme with fixes for Content Security Policy (CSP) violations and automatic redirection issues.

## Problem Statement

Three main issues were resolved:

1. **CSP Violation**: "Framing 'http://10.7.183.76:3000/' violates the following Content Security Policy directive: "frame-src 'self'"
2. **404 Error**: Missing logo image at `/resources/6sqdv/login/sso-pemda/img/logo-pemda-diy.png`
3. **Redirection Issue**: After adding CSP settings, errors disappeared but automatic redirection stopped working

## Solution Overview

### 1. Content-Security-Policy Configuration

Added a comprehensive CSP meta tag to `login/template.ftl` that:
- Allows framing from the redirect URI (solving frame-ancestors violation)
- Permits inline scripts for automatic redirection
- Enables external resources (Tailwind, Google Fonts)
- Allows form submissions and AJAX requests needed for authentication flow

### 2. Resources Structure

Created `login/resources/img/` directory with:
- Placeholder logo (SVG format)
- Documentation and instructions
- Proper directory structure for Keycloak theme resources

### 3. Comprehensive Documentation

Three detailed guides:
- **CSP-CONFIGURATION.md** - CSP setup and configuration
- **DEPLOYMENT.md** - Deployment and testing procedures
- **resources/img/README.md** - Logo resource instructions

## Quick Start

### Deploy to Keycloak

```bash
# Copy theme to Keycloak
cp -r login /opt/keycloak/themes/sso-pemda/
cp -r email /opt/keycloak/themes/sso-pemda/

# Set permissions
chown -R keycloak:keycloak /opt/keycloak/themes/sso-pemda/
chmod -R 755 /opt/keycloak/themes/sso-pemda/

# Restart Keycloak
systemctl restart keycloak
```

### Configure in Keycloak Admin Console

1. Login to Keycloak Admin Console
2. Navigate to: **Realm Settings** → **Themes**
3. Set **Login Theme** to `sso-pemda`
4. Click **Save**

### Replace Logo (Important!)

```bash
# Replace placeholder with actual logo
cp your-logo.png /opt/keycloak/themes/sso-pemda/login/resources/img/logo-pemda-diy.png
```

## Files Modified

### Core Changes
- `login/template.ftl` - Added CSP meta tag in `<head>` section
- `login/resources/img/` - Created directory with placeholder logo

### Documentation Added
- `CSP-CONFIGURATION.md` - Detailed CSP configuration guide
- `DEPLOYMENT.md` - Deployment and testing procedures
- `README.md` - This file

## Key Features of CSP Configuration

```
frame-ancestors: Allows http://10.7.183.76:3000 and localhost:3000
script-src: Allows inline scripts + Tailwind CDN + Google Fonts
style-src: Allows inline styles + CDN resources
font-src: Allows Google Fonts
img-src: Allows all HTTPS images
connect-src: Allows connections to Keycloak server
form-action: Allows form submissions to redirect URI
```

## Testing the Solution

### 1. Check CSP Headers
```bash
curl -I http://10.7.183.76:8080/auth/realms/your-realm/protocol/openid-connect/auth
```

### 2. Verify in Browser
1. Open Developer Tools (F12)
2. Navigate to login page
3. Check Console for CSP violations (should be none)
4. Check Network tab for 404 errors (should be none)

### 3. Test Authentication Flow
1. Try login with invalid credentials
2. Should automatically redirect to QR login page
3. Error message should display in alert box
4. No JavaScript errors in console

## Important Notes

### Environment-Specific Configuration
The CSP includes hardcoded IP addresses (10.7.183.76) specific to the deployment environment. For different environments:

1. Edit `login/template.ftl` line 7
2. Replace IP addresses with your environment's URLs
3. Or use server-level CSP configuration (see CSP-CONFIGURATION.md)

### Security Considerations
The CSP uses `'unsafe-inline'` and `'unsafe-eval'` due to:
- Keycloak theme FreeMarker template requirements
- Tailwind CDN JIT compiler needs
- Inline redirection scripts in authentication flow

For production environments with higher security requirements, consider:
- Server-level CSP configuration with nonces
- CSP headers via reverse proxy (nginx/Apache)
- See CSP-CONFIGURATION.md for alternatives

### Logo Placeholder
The current logo is an SVG placeholder. Replace with actual Pemda DIY logo:
- Format: PNG
- Dimensions: 200x200 pixels (recommended)
- Location: `login/resources/img/logo-pemda-diy.png`

## Troubleshooting

### CSP Violations Still Appear
- Check browser console for specific violation
- Verify CSP meta tag is in `<head>` section
- Check if server-level CSP is overriding theme CSP
- See CSP-CONFIGURATION.md troubleshooting section

### 404 Logo Error
- Verify file exists at `login/resources/img/logo-pemda-diy.png`
- Check file permissions (should be 644)
- Clear browser cache (Ctrl+Shift+R)
- See DEPLOYMENT.md troubleshooting section

### Redirection Not Working
- Check browser console for JavaScript errors
- Verify `script-src 'unsafe-inline'` is in CSP
- Check if `form-action` allows redirect URI
- See DEPLOYMENT.md troubleshooting section

## Documentation

| Document | Purpose |
|----------|---------|
| CSP-CONFIGURATION.md | Detailed CSP setup, directives, alternatives |
| DEPLOYMENT.md | Step-by-step deployment and testing guide |
| login/resources/img/README.md | Logo resource instructions |

## Support

For issues or questions:
1. Check DEPLOYMENT.md for common issues
2. Review CSP-CONFIGURATION.md for configuration details
3. Check Keycloak logs: `/opt/keycloak/standalone/log/server.log`
4. Verify browser console for errors

## References

- [Keycloak Documentation](https://www.keycloak.org/docs/latest/)
- [Keycloak Theme Development](https://www.keycloak.org/docs/latest/server_development/#_themes)
- [MDN: Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
- [OWASP CSP Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Content_Security_Policy_Cheat_Sheet.html)

## License

This is a custom Keycloak theme for Pemda DIY. Check with your organization for licensing details.
