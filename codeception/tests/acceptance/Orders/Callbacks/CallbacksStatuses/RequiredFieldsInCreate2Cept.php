<?php

$I = new AcceptanceTester($scenario);
initTest::login($I);
$I->amOnPage('/admin/components/run/shop/callbacks/statuses');
$I->click('.//*[@id="orderStatusesList"]/section/div[1]/div[2]/div/a');
$I->waitForText('Создание статуса обратного звонка');
$I->click('.//*[@id="mainContent"]/section/div[1]/div[2]/div/button[2]');
$I->see('Это поле обязательное.', './/*[@id="addCallbackStatusForm"]/div[1]/div/label');
$I->click('.//*[@id="mainContent"]/section/div[1]/div[2]/div/a/span[2]');
$I->waitForText('Статусы обратных звонков');

