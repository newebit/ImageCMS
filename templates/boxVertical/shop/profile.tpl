<div class="frame-menu-main vertical-menu m-t_25">
    {\Category\RenderMenu::create()->setConfig(array('cache'=>TRUE))->load('category_menu')}
</div>
<div class="content">

    {//$CI->load->module('wishlist')->renderWL()}
    <div class="frame-inside page-profile">
        <div class="container">
            <div class="f-s_0 title-profile without-crumbs">
                <div class="frame-title">
                    <h1 class="title">{echo encode($profile->getName())}, {lang('Добро пожаловать!','boxVertical')}</h1>
                </div>
            </div>
            <div class="left-personal f-s_0">
                <ul class="tabs tabs-data">
                    <li><button data-href="#my_data" data-source="{shop_url('profile/profile_data')}">{lang('Основные данные','boxVertical')}</button></li>
                    <li><button data-href="#change_pass" data-source="{shop_url('profile/profile_change_pass')}">{lang('Изменить пароль','boxVertical')}</button></li>
                    <li><button data-href="#history_order" data-source="{shop_url('profile/profile_history')}">{lang('История заказа','boxVertical')}</button></li>
                </ul>
                <div class="frame-tabs-ref frame-tabs-profile">
                    <div id="my_data">
                        <div class="preloader"></div>
                    </div>
                    <div id="change_pass">
                        <div class="preloader"></div>
                    </div>
                    <div id="history_order">
                        <div class="preloader"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>