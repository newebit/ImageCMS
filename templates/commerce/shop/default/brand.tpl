{# Variables
# @var model
# @var jsCode
# @var products
# @var totalProducts
# @var brandsInCategory
# @var pagination
# @var cart_data
#}

{$forCompareProducts = $CI->session->userdata('shopForCompare')}

<div class="content">
    <div class="center">
        <div class="filter">
            {if count($incats)>0}
                <div class="title padding_filter">{lang('s_found_in_categories')}</div>
                <div style="padding-left: 15px;">
                    <div class="padding_filter">
                        <span style="cursor: pointer;" class="clear_filter" data-url="{site_url($CI->uri->uri_string())}">{lang('s_cancel')}</span><br/>
                    </div>
                    <div class="padding_filter check_frame">
                        <div>
                            {foreach $categories_names as $item}
                            {if ShopCore::$_GET['categoryId'] == $item.id}<b>{$cat_name = $item.name}{/if}
                                <span style="cursor: pointer;" class="findincats" data-id="{echo $item.id}">{$item.name} ({echo $incats[$item.id]})</span></br>
                            {if ShopCore::$_GET['categoryId'] == $item.id}</b>{/if}
                        {/foreach}    
                </div>
            </div>
        </div>
    {else:}
        <div class="title padding_filter">В категориях ничего не найдено</div>
    {/if}
</div>
<div class="catalog_content">
    <!--   Right sidebar     -->
    <div class="nowelty_auction">
        <!--   New products block     -->
        {if count(getPromoBlock('hot', 3, '', $model->getId()))}
            <div class="box_title">
                <span>{lang('s_new')}</span>
            </div>               
            <ul>
                {foreach getPromoBlock('hot', 3, '', $model->getId()) as $hotProduct}
                    {$discount = ShopCore::app()->SDiscountsManager->productDiscount($hotProduct->id)}
                    {$hot_prices = currency_convert($hotProduct->firstVariant->getPrice(), $hotProduct->firstVariant->getCurrency())}
                    <li class="smallest_item">
                        <div class="photo_block">
                            <a href="{shop_url('product/' . $hotProduct->getUrl())}">
                                <img src="{productImageUrl($hotProduct->getSmallModimage())}" alt="{echo ShopCore::encode($hotProduct->getName())}" />
                            </a>
                        </div>
                        <div class="func_description">
                            <a href="{shop_url('product/' . $hotProduct->getUrl())}" class="title">{echo ShopCore::encode($hotProduct->getName())}</a>
                            <div class="buy">
                                <div class="price f-s_14">                                
                                    {if $discount AND ShopCore::$ci->dx_auth->is_logged_in() === true}
                                        {$prOne = $hot_prices.main.price}
                                        {$prTwo = $hot_prices.main.price}
                                        {$prThree = $prOne - $prTwo / 100 * $discount}
                                        <del class="price price-c_red f-s_12 price-c_9">{echo $hot_prices.main.price} {$hot_prices.main.symbol}</del><br /> 
                                    {else:}
                                        {$prThree = $hot_prices.main.price}
                                    {/if}
                                    {echo $prThree} 
                                    <sub>{$hot_prices.second.symbol}</sub>

                                    {if $NextCS != $CS AND empty($discount)}
                                        <span class="d_b">{echo $hot_prices.second.price} {$hot_prices.second.symbol}</span>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </li>
                {/foreach}
            </ul>
        {/if}
        <!--   New products block     -->

        <!--   Promo products block     -->
        {if count(getPromoBlock('action', 3, '', $model->getId()))}
            <div class="box_title">
                <span>{lang('s_action')}</span>
            </div>
            <ul>
                {foreach getPromoBlock('action', 3, '', $model->getId()) as $hotProduct}
                    {$discount = ShopCore::app()->SDiscountsManager->productDiscount($hotProduct->id)}
                    {$action_prices = currency_convert($hotProduct->firstVariant->getPrice(), $hotProduct->firstVariant->getCurrency())}
                    <li class="smallest_item">
                        <div class="photo_block">
                            <a href="{shop_url('product/' . $hotProduct->getUrl())}">
                                <img src="{productImageUrl($hotProduct->getSmallModImage())}" alt="{echo ShopCore::encode($hotProduct->getName())}" />
                            </a>
                        </div>
                        <div class="func_description">
                            <a href="{shop_url('product/' . $hotProduct->getUrl())}" class="title">{echo ShopCore::encode($hotProduct->getName())}</a>
                            <div class="buy">
                                <div class="price f-s_14">

                                    {if $discount AND ShopCore::$ci->dx_auth->is_logged_in() === true}
                                        {$prOne = $action_prices.main.price}
                                        {$prTwo = $action_prices.main.price}
                                        {$prThree = $prOne - $prTwo / 100 * $discount}
                                        <del class="price price-c_red f-s_12 price-c_9">{echo $action_prices.main.price} {$action_prices.main.symbol}</del><br /> 
                                    {else:}
                                        {$prThree = $action_prices.main.price}
                                    {/if}
                                    {echo $prThree} 
                                    <sub>{$action_prices.second.symbol}</sub>

                                    {if $NextCS != $CS AND empty($discount)}
                                        <span class="d_b">{echo $action_prices.second.price} {$action_prices.second.symbol}</span>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </li>
                {/foreach}
            </ul>
        {/if}
        {widget('latest_news')}
        <!--   Promo products block     -->
    </div>
    <!--   Right sidebar     -->
    <div class="catalog_frame">
        <div class="box_title clearfix">
            <div class="f-s_24">
                <h1 class="d_i">{echo ShopCore::encode($model->getName())} 
                    {if ShopCore::$_GET['categoryId'] != ''}
                        - {echo $cat_name}
                    {/if}</h1>
                <span class="count_search">({$totalProducts})</span>
            </div>
        </div>
        <form method="GET">
            <div class="f_l">
                <span class="v-a_m">Сортировать:&nbsp;</span>
                <div class="lineForm w_145 v-a_m">
                    <select id="sort" name="order">
                        <option value="" {if !ShopCore::$_GET['order']}selected="selected"{/if}>-Нет-</option>
                        <option value="rating" {if ShopCore::$_GET['order']=='rating'}selected="selected"{/if}>{lang('s_po')} {lang('s_rating')}</option>
                        <option value="price" {if ShopCore::$_GET['order']=='price'}selected="selected"{/if}>{lang('s_dewevye')}</option>
                        <option value="price_desc" {if ShopCore::$_GET['order']=='price_desc'}selected="selected"{/if} >{lang('s_dor')}</option>
                        <option value="hit" {if ShopCore::$_GET['order']=='hit'}selected="selected"{/if}>{lang('s_popular')}</option>
                        <option value="hot" {if ShopCore::$_GET['order']=='hot'}selected="selected"{/if}>{lang('s_new')}</option>
                        <option value="action" {if ShopCore::$_GET['order']=='action'}selected="selected"{/if}>{lang('s_action')}</option>
                    </select>
                </div>
            </div>
            <div class="f_r">
                <span class="v-a_m">Товаров на странице:&nbsp;</span>
                <div class="lineForm w_50 v-a_m">
                    <select id="count" name="user_per_page">
                        <option value="12" {if ShopCore::$_GET['user_per_page']=='12'}selected="selected"{/if} >12</option>
                        <option value="24" {if ShopCore::$_GET['user_per_page']=='24'}selected="selected"{/if} >24</option>
                        <option value="36" {if ShopCore::$_GET['user_per_page']=='36'}selected="selected"{/if} >36</option>
                    </select>
                </div>
            </div>
        {if isset($_GET['lp'])}<input type="hidden" name="lp" value="{echo $_GET['lp']}">{/if}
    {if isset($_GET['rp'])}<input type="hidden" name="rp" value="{echo $_GET['rp']}">{/if}
</form>
<ul>
    {if $page_number == 1}
        <li>
            <p>{echo $model->getDescription()}</p>
        </li>
    {/if}
    <!--  Render produts list   -->
    {foreach $products as $product}
        {$discount = ShopCore::app()->SDiscountsManager->productDiscount($product->id)}
        {$style = productInCart($cart_data, $product->getId(), $product->firstVariant->getId(), $product->firstVariant->getStock())}
        <li>
            <div class="photo_block">
                <a href="{shop_url('product/' . $product->url)}">
                    <img id="mim{echo $product->id}" src="{productImageUrl($product->mainModImage)}" alt="{echo ShopCore::encode($product->name)} - {echo $product->id}" />
                    <img id="vim{echo $product->id}" class="smallpimagev" src="" alt="" />
                    {if $product->hot == 1}
                        <div class="promoblock nowelty">{lang('s_shot')}</div>
                    {/if}
                    {if $product->action == 1}
                        <div class="promoblock action">{lang('s_saction')}</div>
                    {/if}
                    {if $product->hit == 1}
                        {$discount = ShopCore::app()->SDiscountsManager->productDiscount($product->id)}
                        <div class="promoblock hit">{lang('s_s_hit')}</div>
                    {/if}
                </a>
                <span class="ajax_refer_marg t-a_c">
                    <span data-prodid="{echo $product->id}" class="compare
                          {if $forCompareProducts && in_array($product->id, $forCompareProducts)}
                              is_avail">
                              <a href="{shop_url('compare')}" class="red">{lang('s_compare')}</a>
                          {else:}
                              toCompare blue">
                              <span class="js blue">{lang('s_compare_add')}</span>
                              <a href="{shop_url('compare')}" class="red" style="display: none;">{lang('s_compare')}</a>
                          {/if}
                    </span>
                </span>
            </div>
            <div class="func_description">
                <a href="{shop_url('product/' . $product->url)}" class="title">{echo ShopCore::encode($product->name)}</a>
                <div class="f-s_0">
                    {if $product->variants[0]->number}
                        <span id="code{echo $product->id}" class="code">
                            {lang('s_kod')} {echo ShopCore::encode($product->variants[0]->number)}
                        </span>
                    {/if}
                    <div>
                        <div class="star_rating">
                            <div id="{echo $model->id}_star_rating" class="rating_nohover {echo count_star(countRating($product->id))} star_rait" data-id="{echo $model->id}">
                                <div id="1" class="rate one">
                                    <span title="1">1</span>
                                </div>
                                <div id="2" class="rate two">
                                    <span title="2">2</span>
                                </div>
                                <div id="3" class="rate three">
                                    <span title="3">3</span>
                                </div>
                                <div id="4" class="rate four">
                                    <span title="4">4</span>
                                </div>
                                <div id="5" class="rate five">
                                    <span title="5">5</span>
                                </div>
                            </div>
                        </div>
                        <a href="{shop_url('product/'.$product->id.'#four')}" rel="nofollow" class="response">
                            {totalComments($product->id)}
                            {echo SStringHelper::Pluralize((int)totalComments($product->id), array(lang('s_review_on'), lang('s_review_tw'), lang('s_review_tre')))}
                        </a>
                        {if count($product->variants)>1}
                            <select class="m-l_10" name="selectVar">
                                {foreach $product->variants as $pv}
                                    {$variant_prices = currency_convert($pv->price, $pv->currency)}
                                    <option class="selectVar"
                                            value="{echo $pv->id}"
                                            data-st="{echo $pv->stock}"
                                            data-cs="{$variant_prices.second.symbol}"
                                            data-spr="{echo number_format($variant_prices.second.price, 2, ".", "")}"
                                            data-pr="{echo number_format($variant_prices.main.price, 2 , ".", "")}"
                                            data-pid="{echo $product->id}"
                                            data-img="{echo $pv->smallimage}"
                                            data-vname="{echo $pv->name}"
                                            data-vnumber="{echo $pv->number}">
                                        {echo $pv->name}
                                    </option>
                                {/foreach}
                            </select>
                        {/if}
                    </div>
                </div>
                <div class="buy">
                    <div class="price f-s_18 d_b">
                        {if (float)$product->old_price > 0}
                            {if $product->old_price > $product->price_in_main}
                                <div>
                                    <del class="price f-s_12 price-c_9" style="margin-top: 1px;">
                                        {echo number_format($product->old_price, 2, ".", "")}
                                        <sub> {$CS}</sub>
                                    </del>
                                </div>
                            {/if}
                        {/if}
                        <div id="pricem{echo $product->id}">
                            {if $discount AND ShopCore::$ci->dx_auth->is_logged_in() === true}
                                {$prOne = $prices.main.price}
                                {$prTwo = $prices.main.price}
                                {$prThree = $prOne - $prTwo / 100 * $discount}
                                <del class="price price-c_red f-s_12 price-c_9">{echo number_format($prices.main.price, 2, ".", "")} {$prices.main.symbol}</del>

                            {else:}
                                {//echo number_format($prices.main.price, 2, ".", "")}
                                {$prThree = $prices.main.price}
                            {/if}
                            {echo number_format($prThree, 2, ".", "")} 
                            <sub>{$prices.main.symbol}</sub>
                            {if $NextCS != $CS AND empty($discount)}
                                <span class="d_b">{echo number_format($prices.second.price, 2, ".", "")} {$prices.second.symbol}</span>
                            {/if}
                        </div>
                    </div>
                    <div id="p{echo $product->id}" class="{$style.class} buttons">
                        <span id="buy{echo $product->id}"
                              class="{$style.identif}"
                              data-varid="{echo $product->variants[0]->id}"
                              data-prodid="{echo $product->id}">
                            {$style.message}
                        </span>
                    </div>
                    <span class="frame_wish-list">
                        {if !is_in_wish($product->id)}
                            <span data-logged_in="{if ShopCore::$ci->dx_auth->is_logged_in()===true}true{/if}"
                                  data-varid="{echo $product->variants[0]->id}"
                                  data-prodid="{echo $product->id}"
                                  class="addToWList">
                                <span class="icon-wish"></span>
                                <span class="js blue">{lang('s_slw')}</span>
                            </span>
                            <a href="/shop/wish_list" class="red" style="display:none;"><span class="icon-wish"></span>{lang('s_ilw')}</a>
                        {else:}
                            <a href="/shop/wish_list" class="red"><span class="icon-wish"></span>{lang('s_ilw')}</a>
                        {/if}
                    </span> 
                </div>

                {if ShopCore::app()->SPropertiesRenderer->renderPropertiesInlineNew($product->id)}
                    <p class="c_b">
                        {echo ShopCore::app()->SPropertiesRenderer->renderPropertiesInlineNew($product->id)}
                        &nbsp;&nbsp;<a href="{shop_url('product/' . $product->url)}" class="t-d_n"><span class="t-d_u">{lang('s_more')}</span> →</a>
                    </p>
                {/if}
            </div>
        </li>
    {/foreach}
    <!--  Render produts list   -->
</ul>
<!--    Pagination    -->
<div class="pagination"><div class="t-a_c">{$pagination}</div></div>
<!--    Pagination    -->
</div>

</div>
</div>
</div>