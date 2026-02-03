<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','email','firstName','lastName'); section>
    <#if section = "form">
        <div class="mb-8">
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">${msg("loginProfileTitle")}</h1>
            <p class="text-gray-500 dark:text-gray-400">${msg("updateProfileSubtitle")}</p>
        </div>

        <form action="${url.loginAction}" class="space-y-5" method="post" id="kc-update-profile-form">
            <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                <div class="p-4 rounded-lg <#if message.type = 'success'>alert-success<#elseif message.type = 'warning'>alert-warning<#elseif message.type = 'error'>alert-error<#elseif message.type = 'info'>alert-info</#if> text-sm flex items-start gap-3">
                    <span class="material-icons-round text-xl flex-shrink-0">
                        <#if message.type = 'success'>check_circle<#elseif message.type = 'warning'>warning<#elseif message.type = 'error'>error<#else>info</#if>
                    </span>
                    <div>
                        <p class="font-medium">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            </#if>

            <#if user.editUsernameAllowed>
                <div class="space-y-1">
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="username">
                        ${msg("username")}
                    </label>
                    <input
                        class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('username')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 text-sm"
                        id="username" 
                        name="username"
                        type="text"
                        value="${(user.username!'')}"
                        autocomplete="username"
                        aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" />
                    <#if messagesPerField.existsError('username')>
                        <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('username'))?no_esc}</p>
                    </#if>
                </div>
            </#if>

            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="email">
                    ${msg("email")}
                </label>
                <input
                    class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('email')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 text-sm"
                    id="email" 
                    name="email"
                    type="email"
                    value="${(user.email!'')}"
                    autocomplete="email"
                    aria-invalid="<#if messagesPerField.existsError('email')>true</#if>" />
                <#if messagesPerField.existsError('email')>
                    <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('email'))?no_esc}</p>
                </#if>
            </div>

            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="firstName">
                    ${msg("firstName")}
                </label>
                <input
                    class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('firstName')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 text-sm"
                    id="firstName" 
                    name="firstName"
                    type="text"
                    value="${(user.firstName!'')}"
                    autocomplete="given-name"
                    aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>" />
                <#if messagesPerField.existsError('firstName')>
                    <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</p>
                </#if>
            </div>

            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="lastName">
                    ${msg("lastName")}
                </label>
                <input
                    class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('lastName')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 text-sm"
                    id="lastName" 
                    name="lastName"
                    type="text"
                    value="${(user.lastName!'')}"
                    autocomplete="family-name"
                    aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>" />
                <#if messagesPerField.existsError('lastName')>
                    <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</p>
                </#if>
            </div>

            <div class="flex gap-3">
                <#if isAppInitiatedAction??>
                    <button
                        class="flex-1 flex justify-center items-center py-3 px-4 border border-gray-300 rounded-lg shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition-colors"
                        type="submit"
                        name="cancel-aia"
                        value="true">
                        ${msg("doCancel")}
                    </button>
                </#if>
                <button
                    class="flex-1 flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors"
                    type="submit">
                    ${msg("doSubmit")}
                </button>
            </div>
        </form>
    <#elseif section = "footer">
        <p class="text-sm text-gray-500 dark:text-gray-400">
            ${msg("needHelp")} 
            <a class="font-medium text-primary dark:text-accent hover:underline" href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" rel="noopener noreferrer">${msg("contactSupport")}</a>
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
    </#if>
</@layout.registrationLayout>
