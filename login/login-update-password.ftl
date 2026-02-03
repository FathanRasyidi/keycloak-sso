<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-new','password-confirm'); section>
    <#if section = "form">
        <div class="mb-8">
            <div class="w-16 h-16 bg-primary/10 dark:bg-accent/10 rounded-full flex items-center justify-center mb-6">
                <span class="material-icons-round text-3xl text-primary dark:text-accent">password</span>
            </div>
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">Ubah Password</h1>
            <p class="text-gray-500 dark:text-gray-400">Silakan buat password baru untuk akun Anda</p>
        </div>

        <form action="${url.loginAction}" class="space-y-5" method="POST" id="kc-passwd-update-form">
            <#-- Alert Error -->

            <input type="text" id="username" name="username" value="${username}" autocomplete="username" readonly="readonly" style="display:none;"/>

            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="password-new">Password Baru</label>
                <div class="relative">
                    <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 text-sm pr-12 <#if messagesPerField.existsError('password-new')>border-red-500</#if>"
                        id="password-new" 
                        name="password-new"
                        placeholder="••••••••" 
                        type="password"
                        autofocus
                        autocomplete="new-password"
                        aria-invalid="<#if messagesPerField.existsError('password-new')>true</#if>" />
                    <button type="button"
                        class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                        onclick="togglePasswordVisibility('password-new', this)">
                        <span class="material-icons-round text-xl">visibility_off</span>
                    </button>
                </div>
                <#if messagesPerField.existsError('password-new')>
                    <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('password-new'))?no_esc}</p>
                </#if>
            </div>

            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="password-confirm">Konfirmasi Password</label>
                <div class="relative">
                    <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 text-sm pr-12 <#if messagesPerField.existsError('password-confirm')>border-red-500</#if>"
                        id="password-confirm" 
                        name="password-confirm"
                        placeholder="••••••••" 
                        type="password"
                        autocomplete="new-password"
                        aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>" />
                    <button type="button"
                        class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                        onclick="togglePasswordVisibility('password-confirm', this)">
                        <span class="material-icons-round text-xl">visibility_off</span>
                    </button>
                </div>
                <#if messagesPerField.existsError('password-confirm')>
                    <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</p>
                </#if>
                <p id="password-mismatch-error" class="hidden text-xs text-red-500 mt-1">Kata sandi tidak cocok</p>
            </div>

            <#-- Password requirements -->
            <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-3 border border-gray-200 dark:border-gray-700">
                <p class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-2">${msg("passwordRequirements")}</p>
                <ul class="text-xs text-gray-500 dark:text-gray-400 space-y-1">
                    <li class="flex items-center gap-2" id="req-length">
                        <span class="material-icons-round text-sm text-gray-400">radio_button_unchecked</span>
                        ${msg("passwordMinLength")}
                    </li>
                    <li class="flex items-center gap-2" id="req-uppercase">
                        <span class="material-icons-round text-sm text-gray-400">radio_button_unchecked</span>
                        ${msg("passwordUppercase")}
                    </li>
                    <li class="flex items-center gap-2" id="req-number">
                        <span class="material-icons-round text-sm text-gray-400">radio_button_unchecked</span>
                        ${msg("passwordNumber")}
                    </li>
                    <li class="flex items-center gap-2" id="req-special">
                        <span class="material-icons-round text-sm text-gray-400">radio_button_unchecked</span>
                        ${msg("passwordSpecial")}
                    </li>
                </ul>
            </div>

            <div class="flex gap-4">
                <#if isAppInitiatedAction??>
                    <button class="flex-1 flex justify-center items-center py-3 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm text-sm font-medium text-gray-700 dark:text-gray-200 bg-white dark:bg-surface-dark hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
                        type="submit" name="cancel-aia" value="true">
                        Lewati
                    </button>
                </#if>
                <button class="flex-1 flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors"
                    type="submit" id="submit-btn">
                    Simpan Password
                </button>
            </div>
        </form>

    <#elseif section = "footer">
        <p class="text-sm text-gray-500 dark:text-gray-400">
            ${msg("needHelp")} <a class="font-medium text-primary dark:text-accent hover:underline" href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" rel="noopener noreferrer">${msg("contactSupport")}</a>
        </p>
        
        <div class="mt-4 pt-4 border-t border-gray-200 dark:border-gray-700">
            <div
                class="flex flex-wrap items-center justify-center lg:justify-start gap-x-4 gap-y-2 text-xs text-gray-500 dark:text-gray-400">
                <a href="https://drive.google.com/file/d/1nvLDfcjULstrpKbt-8o3nSY23FgCMxl4/view" target="_blank"
                    rel="noopener noreferrer"
                    class="inline-flex items-center gap-1 hover:text-primary dark:hover:text-accent transition-colors">
                    <span class="material-icons-round text-sm">policy</span>
                    <span>Kebijakan Privasi</span>
                </a>
                <span class="text-gray-300 dark:text-gray-600">•</span>
                <a href="https://diskominfo.notion.site/28e22b0cdb8080e6a777e835aee5cff7?pvs=105"
                    target="_blank" rel="noopener noreferrer"
                    class="inline-flex items-center gap-1 hover:text-primary dark:hover:text-accent transition-colors">
                    <span class="material-icons-round text-sm">feedback</span>
                    <span>Kritik & Saran</span>
                </a>
                <span class="text-gray-300 dark:text-gray-600">•</span>
                <a href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank"
                    rel="noopener noreferrer"
                    class="inline-flex items-center gap-1 hover:text-primary dark:hover:text-accent transition-colors">
                    <span class="material-icons-round text-sm">support_agent</span>
                    <span>Kontak Kami</span>
                </a>
            </div>
        </div>

    <#elseif section = "info">
        <div class="insight-slider relative overflow-hidden">
            <div class="insight-slide active" data-slide="0">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Keamanan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Password Kuat <br />
                        <span class="text-primary/70 italic font-light">Akun Lebih Aman</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Gunakan kombinasi huruf besar, huruf kecil, angka, dan simbol untuk password yang lebih aman.
                    </p>
                </div>
            </div>
        </div>

    <#elseif section = "script">
        <script>
            const passwordInput = document.getElementById('password-new');
            const confirmPasswordInput = document.getElementById('password-confirm');
            const form = document.getElementById('kc-passwd-update-form');
            const mismatchError = document.getElementById('password-mismatch-error');

            // Prevent form submission if passwords don't match
            if (form) {
                form.addEventListener('submit', function(e) {
                    const password = passwordInput.value;
                    const confirmPassword = confirmPasswordInput.value;
                    
                    if (password !== confirmPassword) {
                        e.preventDefault();
                        mismatchError.classList.remove('hidden');
                        confirmPasswordInput.classList.add('border-red-500');
                        confirmPasswordInput.classList.remove('border-gray-200', 'border-green-500');
                        confirmPasswordInput.focus();
                        return false;
                    }
                });
            }

            if (passwordInput) {
                passwordInput.addEventListener('input', function () {
                    const password = this.value;
                    updateRequirement('req-length', password.length >= 8);
                    updateRequirement('req-uppercase', /[A-Z]/.test(password));
                    updateRequirement('req-number', /[0-9]/.test(password));
                    updateRequirement('req-special', /[!@#$%^&*]/.test(password));
                    checkPasswordMatch();
                    mismatchError.classList.add('hidden');
                });
            }

            if (confirmPasswordInput) {
                confirmPasswordInput.addEventListener('input', function() {
                    checkPasswordMatch();
                    mismatchError.classList.add('hidden');
                });
            }

            function checkPasswordMatch() {
                const password = document.getElementById('password-new').value;
                const confirmPassword = document.getElementById('password-confirm').value;
                const confirmField = document.getElementById('password-confirm');

                if (confirmPassword && password !== confirmPassword) {
                    confirmField.classList.add('border-red-500');
                    confirmField.classList.remove('border-gray-200', 'border-green-500');
                } else if (confirmPassword && password === confirmPassword) {
                    confirmField.classList.add('border-green-500');
                    confirmField.classList.remove('border-red-500', 'border-gray-200');
                } else {
                    confirmField.classList.remove('border-red-500', 'border-green-500');
                    confirmField.classList.add('border-gray-200');
                }
            }

            function updateRequirement(id, valid) {
                const element = document.getElementById(id);
                if (!element) return;
                const icon = element.querySelector('.material-icons-round');

                if (valid) {
                    icon.textContent = 'check_circle';
                    icon.classList.remove('text-gray-400');
                    icon.classList.add('text-green-500');
                } else {
                    icon.textContent = 'radio_button_unchecked';
                    icon.classList.remove('text-green-500');
                    icon.classList.add('text-gray-400');
                }
            }
        </script>
    </#if>
</@layout.registrationLayout>
