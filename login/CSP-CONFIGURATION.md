# Content Security Policy (CSP) Configuration

## Overview

This document explains the Content Security Policy (CSP) configuration applied to the Keycloak login theme to fix CSP violations and enable proper authentication flow with automatic redirection.

## ⚠️ Important Notes

- **Environment-Specific Configuration**: The CSP includes hardcoded IP addresses (10.7.183.76) specific to the deployment environment. For production use or different environments, update these values or use server-level CSP configuration.
- **Security Trade-offs**: The configuration uses `'unsafe-inline'` and `'unsafe-eval'` due to Keycloak theme limitations. For enhanced security in production, consider server-level CSP with nonces.
- **Logo Placeholder**: The logo file in `resources/img/` is a placeholder. Replace with the actual Pemda DIY logo before deployment.

## Problem

The original issues encountered were:

1. **CSP Violation**: `Framing 'http://10.7.183.76:3000/' violates the following Content Security Policy directive: "frame-src 'self'"`
2. **404 Error**: Missing logo image at `resources/6sqdv/login/sso-pemda/img/logo-pemda-diy.png`
3. **Redirection Issue**: After adding CSP settings, the error disappeared but automatic redirection stopped working

## Solution

### 1. CSP Meta Tag Added to template.ftl

A comprehensive CSP meta tag has been added to the `<head>` section of `template.ftl` with the following directives:

```html
<meta http-equiv="Content-Security-Policy" content="
  frame-ancestors 'self' 
    http://10.7.183.76:3000 https://10.7.183.76:3000 
    http://localhost:3000 https://localhost:3000 
    http://10.7.183.76:8080 https://10.7.183.76:8080;
  script-src 'self' 'unsafe-inline' 'unsafe-eval' 
    https://cdn.tailwindcss.com 
    https://fonts.googleapis.com;
  style-src 'self' 'unsafe-inline' 
    https://fonts.googleapis.com 
    https://cdn.tailwindcss.com;
  font-src 'self' https://fonts.gstatic.com;
  img-src 'self' data: https:;
  connect-src 'self' 
    http://10.7.183.76:8080 
    https://10.7.183.76:8080;
  form-action 'self' 
    http://10.7.183.76:3000 
    https://10.7.183.76:3000;
" />
```

### 2. CSP Directives Explained

| Directive | Purpose | Values |
|-----------|---------|--------|
| `frame-ancestors` | Controls which domains can embed this page in an iframe | Allows the application at port 3000 and Keycloak at port 8080 to frame the login page |
| `script-src` | Controls which scripts can execute | Allows inline scripts (needed for automatic redirection), Tailwind CDN, and Google Fonts API |
| `style-src` | Controls which stylesheets can be loaded | Allows inline styles, Tailwind CDN, and Google Fonts |
| `font-src` | Controls which fonts can be loaded | Allows fonts from Google Fonts CDN |
| `img-src` | Controls which images can be loaded | Allows all HTTPS images, data URIs, and self-hosted images |
| `connect-src` | Controls AJAX/fetch requests | Allows connections to Keycloak server (needed for QR code authentication polling) |
| `form-action` | Controls where forms can be submitted | Allows form submissions to the application at port 3000 |

### 3. Key Security Considerations

#### Inline Scripts (`'unsafe-inline'`)

The theme uses inline scripts for:
- **Automatic redirection** in `login.ftl` (line 26): `window.location.href = "${targetUrl?no_esc}";`
- **Error handling** in `qr-login.ftl` (lines 269-285): Reading from sessionStorage and displaying errors
- **Tailwind configuration** in `template.ftl` (lines 11-35): Custom theme configuration
- **UI interactions**: Password visibility toggle, carousel slider

While `'unsafe-inline'` is generally discouraged, it's necessary here because:
1. Keycloak themes use FreeMarker templates that inject dynamic values
2. The authentication flow requires immediate JavaScript execution
3. Adding CSP nonces would require Keycloak server-level configuration changes

#### `'unsafe-eval'`

Required for Tailwind CSS JIT compiler which uses `eval()` for dynamic style generation.

### 4. Resources Directory

Created the following directory structure to resolve the 404 error:

```
login/resources/img/
├── .gitkeep
├── README.md
└── logo-pemda-diy.png (placeholder)
```

**Action Required**: Replace the placeholder `logo-pemda-diy.png` with the actual Pemda DIY logo.

## Alternative Configuration Methods

### Server-Level CSP (Recommended for Production)

For production environments, consider setting CSP headers at the Keycloak server level instead of in the theme:

1. **Via Keycloak Admin Console**:
   - Navigate to: Realm Settings → Security Defenses → Headers
   - Configure Content-Security-Policy

2. **Via standalone.xml (WildFly/JBoss)**:
   ```xml
   <response-header name="Content-Security-Policy" 
                    value="frame-ancestors 'self' https://your-app.com; ..."/>
   ```

3. **Via Reverse Proxy (nginx)**:
   ```nginx
   add_header Content-Security-Policy "frame-ancestors 'self' https://your-app.com; ...";
   ```

### Environment-Specific Configuration

To make the CSP configuration environment-agnostic, you can:

1. Use Keycloak server-level configuration instead of theme-level
2. Implement a wildcard approach (less secure): `frame-ancestors 'self' http://*.domain.com https://*.domain.com`
3. Use environment variables in server configuration

## Testing CSP Configuration

### Verify CSP is Working

1. Open browser Developer Tools (F12)
2. Navigate to the login page
3. Check Console for CSP violations
4. Check Network tab → Response Headers for CSP header

### Test Automatic Redirection

1. Trigger a login error (e.g., invalid credentials)
2. Verify the page automatically redirects to QR login
3. Check that error messages are preserved via sessionStorage

### Test QR Code Flow

1. Click "Login with QR Code"
2. Verify QR code loads without CSP errors
3. Verify status polling works (check Network tab for POST requests)
4. Scan QR code and verify automatic redirection upon approval

## Troubleshooting

### CSP Violations Still Occurring

1. Check browser console for specific violation messages
2. Identify the blocked resource or script
3. Add appropriate directive to CSP meta tag

### Redirection Not Working

1. Verify `script-src 'unsafe-inline'` is present
2. Check if `form-action` allows the redirect target
3. Check browser console for JavaScript errors

### Images Not Loading

1. Verify image files exist in `login/resources/img/`
2. Check `img-src` directive includes necessary sources
3. Verify image paths in template files

### QR Code Polling Fails

1. Verify `connect-src` includes Keycloak server URL
2. Check Network tab for blocked requests
3. Ensure fetch API calls use correct credentials

## References

- [MDN: Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
- [Keycloak Server Installation and Configuration Guide](https://www.keycloak.org/docs/latest/server_installation/)
- [OWASP CSP Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Content_Security_Policy_Cheat_Sheet.html)
