<div class="inside-padd clearfix">
    <div class="frame-change-profile">
        <div class="horizontal-form">
              <form method="post" id="form_change_info" onsubmit="ImageCMSApi.formAction('{site_url("/shop/profileapi/changeInfo")}', '#form_change_info', {literal}{hideForm: false, durationHideForm: 1000}{/literal});
                return false;">
                <label>
                    <span class="title">{lang('Ваше имя','newLevel')}:</span>
                    <span class="frame-form-field">
                        <input type="text" value="{echo encode($profile->getName())}" name="name"/>
                        <span class="help-block">{lang('Не меньше 4-х символов','newLevel')}</span>
                    </span>
                </label>
                <label>
                    <span class="title">{lang('Телефон','newLevel')}:</span>
                    <span class="frame-form-field">
                        <input type="text" value="{echo encode($profile->getPhone())}" name="phone"/>
                    </span>
                </label>
                <label>
                    <span class="title">Email:</span>
                    <span class="frame-form-field">
                        <input type="text" disabled="disabled" value="{echo encode($profile->getUserEmail())}" name="email"/>
                        <input type="hidden" value="{echo encode($profile->getUserEmail())}" name="email"/>
                        <span class="help-block">{lang('E-mail является логином','newLevel')}</span>
                    </span>
                </label>
                {echo ShopCore::app()->CustomFieldsHelper->setRequiredHtml('<span class="must">*</span>')->setPatternMain('pattern_custom_field')->getOneCustomFieldsByName('city','user',$profile->getId())->asHtml()}
                <label>
                    <span class="title">{lang('Адрес','newLevel')}:</span>
                    <span class="frame-form-field">
                        <input type="text" value="{echo encode($profile->getAddress())}" name="address"/>
                    </span>
                </label>
                <div class="frame-label">
                    <span class="title">&nbsp;</span>
                    <span class="frame-form-field">
                        <span class="btn-form">
                            <input type="submit" value="{lang('Сохранить данные','newLevel')}"/>
                        </span>
                    </span>
                </div>
                {form_csrf()}
            </form>
        </div>
    </div>
    {$discount = $CI->load->module('mod_discount/discount_api')->get_user_discount_api()}
    {if $discount['user'] or $discount['group_user'] or $discount['comulativ']}
        <div class="layout-highlight info-discount">
            <div class="title-default">
                <div class="title">{lang('Скидки','newLevel')}</div>
            </div>
            <div class="content">
                <ul class="items items-info-discount">
                    <li class="inside-padd">
                        <div>
                            {lang('Товаров на сумму','newLevel')}:
                            <span class="price-item">
                                <span class="text-discount">
                                    <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($profile->getamout())}</span>
                                    <span class="curr">{$CS}</span>
                                </span>
                            </span>
                        </div>
                        {if $discount['user']}
                            <div>
                                {lang('Ваша текущая скидка','newLevel')}:
                                <span class="price-item">
                                    <span class="text-discount">{echo $discount['user'][0]['value']}{if $discount['user'][0]['type_value'] == 1}%{else:}{$CS}{/if}</span>
                                </span>
                            </div>
                        {/if}
                        {if $discount['group_user']}
                            <div>
                                {lang('Ваша текущая скидка группы пользователей','newLevel')}:
                                <span class="price-item">
                                    <span class="text-discount">{echo $discount['group_user'][0]['value']}{if  $discount['group_user'][0]['type_value'] == 1}%{else:}{$CS}{/if}</span>
                                </span>
                            </div>
                        {/if}
                        {if $discount['comulativ']}
                            {foreach $discount['comulativ'] as $key => $disc}
                                {if $disc['begin_value'] < $profile->getamout() and $profile->getamout() < $disc['end_value']}
                                    {$discount_comul_next = $discount['comulativ'][$key + 1];}
                                    {$discount_comul_curr = $discount['comulativ'][$key];}
                                {/if}
                            {/foreach}
                        {/if}
                        {if $discount_comul_curr}
                            <div>
                                {lang('Ваша текущая скидка','newLevel')}:
                                <span class="price-item">
                                    <span class="text-discount">{echo $discount_comul_curr['value']}{if  $discount_comul_curr['type_value'] == 1}%{else:}{$CS}{/if}</span>
                                </span>
                            </div>
                        {/if}

                    </li>

                    {if $discount_comul_next}
                        <li class="inside-padd">
                            <div>{lang('Для следующих скидкок','newLevel')} {echo $discount_comul_next['value']}{if  $discount_comul_next['type_value'] == 1}%{else:}{$CS}{/if}</b> {lang('оставить','newLevel')}</div>
                            <div>{lang('Сделать покупки по ценам','newLevel')}: <b>{echo $discount_comul_next['begin_value'] - $profile->getamout()} {$CS}</b></div>
                        </li>
                    {/if}
                    {if  $discount['comulativ']}
                        <li class="inside-padd">
                            <button type="button" class="d_l_1" data-drop=".drop-comulativ-discounts" data-place="noinherit" data-placement="top left" data-overlay-opacity= "0">{lang('Посмотреть таблицу скидок','newLevel')}</button>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>
{/if}
{if  $discount['comulativ']}
    <div class="drop-style drop drop-comulativ-discounts">
        <button type="button" class="icon_times_drop" data-closed="closed-js"></button>
        <div class="drop-header">
            <div class="title">{lang('Накопительные скидки','newLevel')}</div>
        </div>
        <div class="drop-content">
            <div class="inside-padd characteristic">
                
                    
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    asdf
                    <br/>
                    
            </div>
        </div>
        <div class="drop-footer"></div>
    </div>
{/if}