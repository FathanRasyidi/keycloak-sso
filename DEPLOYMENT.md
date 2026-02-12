# Deployment and Testing Guide

## Overview

This guide explains how to deploy the CSP fixes and test the authentication flow to ensure the issues are resolved.

## Pre-Deployment Checklist

- [ ] Replace placeholder `logo-pemda-diy.svg` with actual Pemda DIY logo (`logo-pemda-diy.png`)
- [ ] Review and update IP addresses in CSP configuration if deploying to a different environment
- [ ] Backup existing Keycloak theme (if any)
- [ ] Verify Keycloak version compatibility

## Deployment Steps

### 1. Deploy Theme to Keycloak

**Option A: Manual Deployment**

1. Copy the entire theme directory to Keycloak:
   ```bash
   # Assuming keycloak installation at /opt/keycloak
   cp -r login /opt/keycloak/themes/sso-pemda/
   cp -r email /opt/keycloak/themes/sso-pemda/
   ```

2. Set correct ownership and permissions:
   ```bash
   chown -R keycloak:keycloak /opt/keycloak/themes/sso-pemda/
   chmod -R 755 /opt/keycloak/themes/sso-pemda/
   ```

**Option B: JAR Deployment**

1. Package theme as JAR:
   ```bash
   cd /path/to/keycloak-sso
   jar -cvf sso-pemda-theme.jar login/ email/
   ```

2. Deploy JAR to Keycloak:
   ```bash
   cp sso-pemda-theme.jar /opt/keycloak/standalone/deployments/
   ```

### 2. Configure Realm to Use Theme

1. Login to Keycloak Admin Console
2. Navigate to: **Realm Settings** → **Themes**
3. Set the following:
   - **Login Theme**: `sso-pemda` (or your theme name)
   - **Email Theme**: `sso-pemda` (optional)
4. Click **Save**

### 3. Clear Keycloak Cache (if needed)

```bash
# For standalone mode
/opt/keycloak/bin/jboss-cli.sh --connect --command="/subsystem=keycloak-server:clear-cache"

# Or restart Keycloak
systemctl restart keycloak
```

## Testing Procedures

### Test 1: Verify CSP Headers

1. **Open browser Developer Tools** (F12)
2. **Navigate to login page**: `http://10.7.183.76:8080/auth/realms/your-realm/protocol/openid-connect/auth?client_id=web-app&redirect_uri=http://10.7.183.76:3000/callback&response_type=code&scope=openid`
3. **Check Response Headers**:
   - Open **Network** tab
   - Find the auth page request
   - Verify `Content-Security-Policy` header is present
4. **Check Console**:
   - No CSP violation errors should appear
   - Should see: "Content Security Policy: frame-ancestors..."

**Expected Result**: ✅ No CSP violation errors

### Test 2: Verify Logo Loading

1. **Navigate to login page**
2. **Check browser console** for 404 errors
3. **Verify logo appears** at top-left of login form
4. **If placeholder SVG appears**: Replace with actual PNG logo

**Expected Result**: ✅ Logo loads without 404 errors

### Test 3: Test Automatic Redirection (Error Flow)

1. **Navigate to login page**
2. **Enter invalid credentials**
3. **Submit the form**
4. **Observe behavior**:
   - Should automatically redirect to QR login page
   - Error message should appear in alert box
   - No JavaScript errors in console

**Expected Result**: ✅ Automatic redirect works, error message displayed

### Test 4: Test QR Code Authentication

1. **Click "Login with QR Code"** (if available)
2. **Verify QR code displays** without CSP errors
3. **Check Network tab**:
   - Should see periodic POST requests (every 5 seconds)
   - Requests should not be blocked by CSP
4. **Scan QR code** with mobile device
5. **Approve authentication** on mobile
6. **Observe automatic redirect** to application

**Expected Result**: ✅ QR code works, polling succeeds, automatic redirect occurs

### Test 5: Test Standard Login Flow

1. **Navigate to login page**
2. **Enter valid credentials**
3. **Submit the form**
4. **Verify redirect** to application at `http://10.7.183.76:3000/callback`
5. **Check that authentication code** is passed in URL parameters

**Expected Result**: ✅ Login succeeds, redirects to application with auth code

### Test 6: Test Iframe Embedding (if applicable)

1. **Create test HTML page**:
   ```html
   <!DOCTYPE html>
   <html>
   <body>
     <h1>Iframe Test</h1>
     <iframe src="http://10.7.183.76:8080/auth/realms/your-realm/protocol/openid-connect/auth?client_id=web-app&redirect_uri=http://10.7.183.76:3000/callback&response_type=code" 
             width="800" height="600"></iframe>
   </body>
   </html>
   ```

2. **Open page from same origin** (http://10.7.183.76:3000)
3. **Verify iframe loads** without CSP errors

**Expected Result**: ✅ Iframe loads when allowed by frame-ancestors

## Troubleshooting

### Issue: CSP Violations Still Appear

**Symptoms**: Console shows "Content Security Policy violation"

**Solutions**:
1. Check if server-level CSP is overriding theme-level CSP
2. Verify CSP meta tag is in `<head>` section
3. Check browser console for specific violation details
4. Update CSP directives to allow the blocked resource

**Commands**:
```bash
# Check Keycloak server logs
tail -f /opt/keycloak/standalone/log/server.log

# Check response headers
curl -I http://10.7.183.76:8080/auth/realms/your-realm/protocol/openid-connect/auth
```

### Issue: 404 Error for Logo

**Symptoms**: Logo doesn't load, 404 error in console

**Solutions**:
1. Verify file exists: `login/resources/img/logo-pemda-diy.png`
2. Check file permissions: `chmod 644 login/resources/img/logo-pemda-diy.png`
3. Verify theme is properly deployed
4. Clear browser cache: Ctrl+Shift+R

**Commands**:
```bash
# Check if file exists in deployed theme
ls -la /opt/keycloak/themes/sso-pemda/login/resources/img/

# Verify file content type
file /opt/keycloak/themes/sso-pemda/login/resources/img/logo-pemda-diy.png
```

### Issue: Redirection Not Working

**Symptoms**: Login form submits but doesn't redirect

**Solutions**:
1. Check browser console for JavaScript errors
2. Verify `script-src 'unsafe-inline'` is in CSP
3. Check if `form-action` allows redirect URI
4. Verify `window.location.href` is not blocked

**Debugging**:
```javascript
// In browser console, test if JavaScript can redirect:
window.location.href = "http://10.7.183.76:3000/"
```

### Issue: QR Code Polling Fails

**Symptoms**: QR code displays but doesn't detect scan

**Solutions**:
1. Check Network tab for blocked fetch requests
2. Verify `connect-src` allows Keycloak server URL
3. Check Keycloak server logs for authentication flow errors
4. Verify QR code authentication is enabled in Keycloak

**Commands**:
```bash
# Check Keycloak authentication flows
/opt/keycloak/bin/kcadm.sh get authentication/flows -r your-realm
```

## Environment-Specific Configuration

### For Production Environment

Replace hardcoded IPs with production URLs:

1. **Edit `login/template.ftl`**:
   ```html
   <!-- Change from: -->
   frame-ancestors 'self' http://10.7.183.76:3000 ...
   
   <!-- Change to: -->
   frame-ancestors 'self' https://your-app.example.com ...
   ```

2. **Consider server-level CSP**:
   - More maintainable
   - Doesn't require theme modifications
   - See `CSP-CONFIGURATION.md` for details

### For Multiple Environments

Use Keycloak server-level configuration with environment variables:

```bash
# Set environment variables
export APP_URL=https://your-app.example.com
export KEYCLOAK_URL=https://keycloak.example.com

# Configure in standalone.xml or via CLI
/opt/keycloak/bin/kcadm.sh update realms/your-realm -s 'contentSecurityPolicy="frame-ancestors 'self' ${env.APP_URL}; ..."'
```

## Validation Checklist

After deployment, verify:

- [ ] Login page loads without console errors
- [ ] Logo displays correctly (no 404)
- [ ] No CSP violation errors in console
- [ ] Login with valid credentials redirects to application
- [ ] Login with invalid credentials shows error and redirects to QR page
- [ ] QR code authentication works (if applicable)
- [ ] Forms can be submitted without CSP blocks
- [ ] Automatic redirection works for all flows
- [ ] Application receives authentication code correctly

## Rollback Procedure

If issues occur:

1. **Revert to previous theme**:
   ```bash
   cp -r /opt/keycloak/themes/sso-pemda.backup /opt/keycloak/themes/sso-pemda/
   ```

2. **Or change theme in Admin Console**:
   - Realm Settings → Themes
   - Change Login Theme to `keycloak` (default)

3. **Restart Keycloak**:
   ```bash
   systemctl restart keycloak
   ```

## Support and References

- **CSP Configuration**: See `CSP-CONFIGURATION.md`
- **Keycloak Documentation**: https://www.keycloak.org/docs/latest/
- **Theme Development**: https://www.keycloak.org/docs/latest/server_development/#_themes
- **CSP Reference**: https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP

## Next Steps

1. Monitor Keycloak logs for errors
2. Gather user feedback on login experience
3. Consider implementing server-level CSP for production
4. Replace placeholder logo with actual Pemda DIY logo
5. Update IP addresses for different environments as needed
