{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{capture name=path}
	{if !isset($email_create)}{l s='Authentication'}{else}
		<a href="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Authentication'}">{l s='Authentication'}</a>
		<span class="navigation-pipe">{$navigationPipe}</span>{l s='Create your account'}
	{/if}
{/capture}
<h1 class="page-heading">{if !isset($email_create)}{l s='Authentication'}{else}{l s='Create an account'}{/if}</h1>
{if isset($back) && preg_match("/^http/", $back)}{assign var='current_step' value='login'}{include file="$tpl_dir./order-steps.tpl"}{/if}
{include file="$tpl_dir./errors.tpl"}
{assign var='stateExist' value=false}
{assign var="postCodeExist" value=false}
{assign var="dniExist" value=false}
{if !isset($email_create)}
	<!--{if isset($authentification_error)}
	<div class="alert alert-danger">
		{if {$authentification_error|@count} == 1}
			<p>{l s='There\'s at least one error'} :</p>
			{else}
			<p>{l s='There are %s errors' sprintf=[$account_error|@count]} :</p>
		{/if}
		<ol>
			{foreach from=$authentification_error item=v}
				<li>{$v}</li>
			{/foreach}
		</ol>
	</div>
	{/if}-->
	<div class="row">
		<div class="col-xs-12 col-sm-6">
		<!-- Ocultar registrar cliente --->	<form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="create-account_form" class="box">
				<h3 class="page-subheading">{l s='Create an account'}</h3>
				<div class="form_content clearfix">
					<p>{l s='Please enter your email address to create an account.'}</p>
					<div class="alert alert-danger" id="create_account_error" style="display:none"></div>
					<div class="form-group">
						<label for="email_create">{l s='Email address'}</label>
						<input type="email" class="is_required validate account_input form-control" data-validate="isEmail" id="email_create" name="email_create" value="{if isset($smarty.post.email_create)}{$smarty.post.email_create|stripslashes}{/if}" />
					</div>
					<div class="submit">
						{if isset($back)}<input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}" />{/if}
						<button class="btn btn-default button button-medium exclusive" type="submit" id="SubmitCreate" name="SubmitCreate">
							<span>
								<i class="icon-user left"></i>
								{l s='Create an account'}
							</span>
						</button>
						<input type="hidden" class="hidden" name="SubmitCreate" value="{l s='Create an account'}" />
					</div>
				</div>
			</form>
		</div>
		<div class="col-xs-12 col-sm-6">
			<form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="login_form" class="box">
				<h3 class="page-subheading">{l s='Already registered?'}</h3>
				<div class="form_content clearfix">
					<div class="form-group">
						<label for="email">{l s='Email address'}</label>
						<input class="is_required validate account_input form-control" data-validate="isEmail" type="email" id="email" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}" />
					</div>
					<div class="form-group">
						<label for="passwd">{l s='Password'}</label>
						<input class="is_required validate account_input form-control" type="password" data-validate="isPasswd" id="passwd" name="passwd" value="" />
					</div>
					<p class="lost_password form-group"><a href="{$link->getPageLink('password')|escape:'html':'UTF-8'}" title="{l s='Recover your forgotten password'}" rel="nofollow">{l s='Forgot your password?'}</a></p>
					<p class="submit">
						{if isset($back)}<input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}" />{/if}
						<button type="submit" id="SubmitLogin" name="SubmitLogin" class="button btn btn-default button-medium">
							<span>
								<i class="icon-lock left"></i>
								{l s='Sign in'}
							</span>
						</button>
					</p>
				</div>
			</form>
		</div>
	</div>
	{if isset($inOrderProcess) && $inOrderProcess && $PS_GUEST_CHECKOUT_ENABLED}
		<form action="{$link->getPageLink('authentication', true, NULL, "back=$back")|escape:'html':'UTF-8'}" method="post" id="new_account_form" class="std clearfix">
			<div class="box">
				<div id="opc_account_form" style="display: block; ">
					<h3 class="page-heading bottom-indent">{l s='Instant checkout'}</h3>
					<!-- Account -->
					<div class="required form-group">
						<label for="guest_email">{l s='Email address'} <sup>*</sup></label>
						<input type="text" class="is_required validate form-control" data-validate="isEmail" id="guest_email" name="guest_email" value="{if isset($smarty.post.guest_email)}{$smarty.post.guest_email}{/if}" />
					</div>
					<div class="cleafix gender-line">
						<label>{l s='Title'}</label>
						{foreach from=$genders key=k item=gender}
							<div class="radio-inline">
								<label for="id_gender{$gender->id}" class="top">
									<input type="radio" name="id_gender" id="id_gender{$gender->id}" value="{$gender->id}"{if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id} checked="checked"{/if} />
									{$gender->name}
								</label>
							</div>
						{/foreach}
					</div>
                    <div class="required form-group">	
                         <label for="rut">{l s='rut'} <sup>*</sup></label>
                        <input class="text" id="rut" type="text" name="rut" />
					</div>
					<div class="required form-group">
						<label for="firstname">{l s='First name'} <sup>*</sup></label>
						<input type="text" class="is_required validate form-control" data-validate="isName" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}" />
					</div>
					<div class="required form-group">
						<label for="lastname">{l s='Last name'} <sup>*</sup></label>
						<input type="text" class="is_required validate form-control" data-validate="isName" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}" />
					</div>
					<div class="form-group date-select">
						<label>{l s='Date of Birth'}</label>
						<div class="row">
							<div class="col-xs-4">
								<select id="days" name="days" class="form-control">
									<option value="">-</option>
									{foreach from=$days item=day}
										<option value="{$day}" {if ($sl_day == $day)} selected="selected"{/if}>{$day}&nbsp;&nbsp;</option>
									{/foreach}
								</select>
								{*
									{l s='January'}
									{l s='February'}
									{l s='March'}
									{l s='April'}
									{l s='May'}
									{l s='June'}
									{l s='July'}
									{l s='August'}
									{l s='September'}
									{l s='October'}
									{l s='November'}
									{l s='December'}
								*}
							</div>
							<div class="col-xs-4">
								<select id="months" name="months" class="form-control">
									<option value="">-</option>
									{foreach from=$months key=k item=month}
										<option value="{$k}" {if ($sl_month == $k)} selected="selected"{/if}>{l s=$month}&nbsp;</option>
									{/foreach}
								</select>
							</div>
							<div class="col-xs-4">
								<select id="years" name="years" class="form-control">
									<option value="">-</option>
									{foreach from=$years item=year}
										<option value="{$year}" {if ($sl_year == $year)} selected="selected"{/if}>{$year}&nbsp;&nbsp;</option>
									{/foreach}
								</select>
							</div>
						</div>
					</div>
					{if isset($newsletter) && $newsletter}
						<div class="checkbox">
							<label for="newsletter">
							<input type="checkbox" name="newsletter" id="newsletter" value="1" {if isset($smarty.post.newsletter) && $smarty.post.newsletter == '1'}checked="checked"{/if} />
							{l s='Sign up for our newsletter!'}</label>
						</div>
					{/if}
					{if isset($optin) && $optin}
						<div class="checkbox">
							<label for="optin">
							<input type="checkbox" name="optin" id="optin" value="1" {if isset($smarty.post.optin) && $smarty.post.optin == '1'}checked="checked"{/if} />
							{l s='Receive special offers from our partners!'}</label>
						</div>
					{/if}
					<h3 class="page-heading bottom-indent top-indent">{l s='Delivery address'}</h3>
					{foreach from=$dlv_all_fields item=field_name}
						{if $field_name eq "company"}
							<div class="form-group">
								<label for="company">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}" />
							</div>
						{elseif $field_name eq "vat_number"}
							<div id="vat_number" style="display:none;">
								<div class="form-group">
									<label for="vat-number">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
									<input id="vat-number" type="text" class="form-control" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{/if}" />
								</div>
							</div>
							{elseif $field_name eq "dni"}
							{assign var='dniExist' value=true}
							<div class="required dni form-group">
								<label for="dni">{l s='Identification number'} <sup>*</sup></label>
								<input type="text" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{/if}" />
								<span class="form_info">{l s='DNI / NIF / NIE'}</span>
							</div>
						{elseif $field_name eq "address1"}
							<div class="required form-group">
								<label for="address1">{l s='Address'} <sup>*</sup></label>
								<input type="text" class="form-control" name="address1" id="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{/if}" />
							</div>
						{elseif $field_name eq "address2"}
							<div class="form-group is_customer_param">
								<label for="address2">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" name="address2" id="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}" />
							</div>
						{elseif $field_name eq "postcode"}
							{assign var='postCodeExist' value=true}
							<div class="required postcode form-group">
								<label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
								<input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}"/>
							</div>
						{elseif $field_name eq "city"}
							<div class="required form-group">
								<label for="city">{l s='City'} <sup>*</sup></label>
								<input type="text" class="form-control" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}" />
							</div>
							<!-- if customer hasn't update his layout address, country has to be verified but it's deprecated -->
						{elseif $field_name eq "Country:name" || $field_name eq "country"}
							<div class="required select form-group">
								<label for="id_country">{l s='Country'} <sup>*</sup></label>
								<select name="id_country" id="id_country" class="form-control">
									{foreach from=$countries item=v}
										<option value="{$v.id_country}"{if (isset($smarty.post.id_country) AND  $smarty.post.id_country == $v.id_country) OR (!isset($smarty.post.id_country) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name}</option>
									{/foreach}
								</select>
							</div>
						{elseif $field_name eq "State:name"}
							{assign var='stateExist' value=true}
							<div class="required id_state select form-group">
								<label for="id_state">{l s='State'} <sup>*</sup></label>
								<select name="id_state" id="id_state" class="form-control">
									<option value="">-</option>
								</select>
							</div>
						{/if}
					{/foreach}
					{if $stateExist eq false}
						<div class="required id_state select unvisible form-group">
							<label for="id_state">{l s='State'} <sup>*</sup></label>
							<select name="id_state" id="id_state" class="form-control">
								<option value="">-</option>
							</select>
						</div>
					{/if}
					{if $postCodeExist eq false}
						<div class="required postcode unvisible form-group">
							<label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
							<input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}"/>
						</div>
					{/if}
					{if $dniExist eq false}
						<div class="required form-group dni">
							<label for="dni">{l s='Identification number'} <sup>*</sup></label>
							<input type="text" class="text form-control" name="dni" id="dni" value="{if isset($smarty.post.dni) && $smarty.post.dni}{$smarty.post.dni}{/if}" />
							<span class="form_info">{l s='DNI / NIF / NIE'}</span>
						</div>
					{/if}
					<div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
						<label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>*</sup>{/if}</label>
						<input type="text" class="form-control" name="phone_mobile" id="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{/if}" />
					</div>
					<input type="hidden" name="alias" id="alias" value="{l s='My address'}" />
					<input type="hidden" name="is_new_customer" id="is_new_customer" value="0" />
					<div class="checkbox">
						<label for="invoice_address">
						<input type="checkbox" name="invoice_address" id="invoice_address"{if (isset($smarty.post.invoice_address) && $smarty.post.invoice_address) || (isset($smarty.post.invoice_address) && $smarty.post.invoice_address)} checked="checked"{/if} autocomplete="off"/>
						{l s='Please use another address for invoice'}</label>
					</div>
					<div id="opc_invoice_address"  class="unvisible">
						{assign var=stateExist value=false}
						{assign var=postCodeExist value=false}
						{assign var=dniExist value=false}
						<h3 class="page-subheading top-indent">{l s='Invoice address'}</h3>
						{foreach from=$inv_all_fields item=field_name}
						{if $field_name eq "company"}
						<div class="form-group">
							<label for="company_invoice">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
							<input type="text" class="text form-control" id="company_invoice" name="company_invoice" value="{if isset($smarty.post.company_invoice) && $smarty.post.company_invoice}{$smarty.post.company_invoice}{/if}" />
						</div>
						{elseif $field_name eq "vat_number"}
						<div id="vat_number_block_invoice" style="display:none;">
							<div class="form-group">
								<label for="vat_number_invoice">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" id="vat_number_invoice" name="vat_number_invoice" value="{if isset($smarty.post.vat_number_invoice) && $smarty.post.vat_number_invoice}{$smarty.post.vat_number_invoice}{/if}" />
							</div>
						</div>
						{elseif $field_name eq "dni"}
						{assign var=dniExist value=true}
						<div class="required form-group dni_invoice">
							<label for="dni_invoice">{l s='Identification number'} <sup>*</sup></label>
							<input type="text" class="text form-control" name="dni_invoice" id="dni_invoice" value="{if isset($smarty.post.dni_invoice) && $smarty.post.dni_invoice}{$smarty.post.dni_invoice}{/if}" />
							<span class="form_info">{l s='DNI / NIF / NIE'}</span>
						</div>
						{elseif $field_name eq "firstname"}
						<div class="required form-group">
							<label for="firstname_invoice">{l s='First name'} <sup>*</sup></label>
							<input type="text" class="form-control" id="firstname_invoice" name="firstname_invoice" value="{if isset($smarty.post.firstname_invoice) && $smarty.post.firstname_invoice}{$smarty.post.firstname_invoice}{/if}" />
						</div>
						{elseif $field_name eq "lastname"}
						<div class="required form-group">
							<label for="lastname_invoice">{l s='Last name'} <sup>*</sup></label>
							<input type="text" class="form-control" id="lastname_invoice" name="lastname_invoice" value="{if isset($smarty.post.lastname_invoice) && $smarty.post.lastname_invoice}{$smarty.post.lastname_invoice}{/if}" />
						</div>
						{elseif $field_name eq "address1"}
						<div class="required form-group">
							<label for="address1_invoice">{l s='Address'} <sup>*</sup></label>
							<input type="text" class="form-control" name="address1_invoice" id="address1_invoice" value="{if isset($smarty.post.address1_invoice) && $smarty.post.address1_invoice}{$smarty.post.address1_invoice}{/if}" />
						</div>
						{elseif $field_name eq "address2"}
						<div class="form-group is_customer_param">
							<label for="address2_invoice">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
							<input type="text" class="form-control" name="address2_invoice" id="address2_invoice" value="{if isset($smarty.post.address2_invoice) && $smarty.post.address2_invoice}{$smarty.post.address2_invoice}{/if}" />
						</div>
						{elseif $field_name eq "postcode"}
						{$postCodeExist = true}
						<div class="required postcode_invoice form-group">
							<label for="postcode_invoice">{l s='Zip/Postal Code'} <sup>*</sup></label>
							<input type="text" class="validate form-control" name="postcode_invoice" id="postcode_invoice" data-validate="isPostCode" value="{if isset($smarty.post.postcode_invoice) && $smarty.post.postcode_invoice}{$smarty.post.postcode_invoice}{/if}"/>
						</div>
						{elseif $field_name eq "city"}
						<div class="required form-group">
							<label for="city_invoice">{l s='City'} <sup>*</sup></label>
							<input type="text" class="form-control" name="city_invoice" id="city_invoice" value="{if isset($smarty.post.city_invoice) && $smarty.post.city_invoice}{$smarty.post.city_invoice}{/if}" />
						</div>
						{elseif $field_name eq "country" || $field_name eq "Country:name"}
						<div class="required form-group">
							<label for="id_country_invoice">{l s='Country'} <sup>*</sup></label>
							<select name="id_country_invoice" id="id_country_invoice" class="form-control">
								<option value="">-</option>
								{foreach from=$countries item=v}
								<option value="{$v.id_country}"{if (isset($smarty.post.id_country_invoice) && $smarty.post.id_country_invoice == $v.id_country) OR (!isset($smarty.post.id_country_invoice) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name|escape:'html':'UTF-8'}</option>
								{/foreach}
							</select>
						</div>
						{elseif $field_name eq "state" || $field_name eq 'State:name'}
						{$stateExist = true}
						<div class="required id_state_invoice form-group" style="display:none;">
							<label for="id_state_invoice">{l s='State'} <sup>*</sup></label>
							<select name="id_state_invoice" id="id_state_invoice" class="form-control">
								<option value="">-</option>
							</select>
						</div>
						{/if}
						{/foreach}
						{if !$postCodeExist}
						<div class="required postcode_invoice form-group unvisible">
							<label for="postcode_invoice">{l s='Zip/Postal Code'} <sup>*</sup></label>
							<input type="text" class="form-control" name="postcode_invoice" id="postcode_invoice" value="{if isset($smarty.post.postcode_invoice) && $smarty.post.postcode_invoice}{$smarty.post.postcode_invoice}{/if}"/>
						</div>
						{/if}
						{if !$stateExist}
						<div class="required id_state_invoice form-group unvisible">
							<label for="id_state_invoice">{l s='State'} <sup>*</sup></label>
							<select name="id_state_invoice" id="id_state_invoice" class="form-control">
								<option value="">-</option>
							</select>
						</div>
						{/if}
						{if $dniExist eq false}
							<div class="required form-group dni_invoice">
								<label for="dni">{l s='Identification number'} <sup>*</sup></label>
								<input type="text" class="text form-control" name="dni_invoice" id="dni_invoice" value="{if isset($smarty.post.dni_invoice) && $smarty.post.dni_invoice}{$smarty.post.dni_invoice}{/if}" />
								<span class="form_info">{l s='DNI / NIF / NIE'}</span>
							</div>
						{/if}
						<div class="form-group is_customer_param">
							<label for="other_invoice">{l s='Additional information'}</label>
							<textarea class="form-control" name="other_invoice" id="other_invoice" cols="26" rows="3"></textarea>
						</div>
						{if isset($one_phone_at_least) && $one_phone_at_least}
							<p class="inline-infos required is_customer_param">{l s='You must register at least one phone number.'}</p>
						{/if}
						<div class="form-group is_customer_param">
							<label for="phone_invoice">{l s='Home phone'}</label>
							<input type="text" class="form-control" name="phone_invoice" id="phone_invoice" value="{if isset($smarty.post.phone_invoice) && $smarty.post.phone_invoice}{$smarty.post.phone_invoice}{/if}" />
						</div>
						<div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
							<label for="phone_mobile_invoice">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>*</sup>{/if}</label>
							<input type="text" class="form-control" name="phone_mobile_invoice" id="phone_mobile_invoice" value="{if isset($smarty.post.phone_mobile_invoice) && $smarty.post.phone_mobile_invoice}{$smarty.post.phone_mobile_invoice}{/if}" />
						</div>
						<input type="hidden" name="alias_invoice" id="alias_invoice" value="{l s='My Invoice address'}" />
					</div>
					<!-- END Account -->
				</div>
				{$HOOK_CREATE_ACCOUNT_FORM}
			</div>
			<p class="cart_navigation required submit clearfix">
				<span><sup>*</sup>{l s='Required field'}</span>
				<input type="hidden" name="display_guest_checkout" value="1" />
				<button type="submit" class="button btn btn-default button-medium" name="submitGuestAccount" id="submitGuestAccount">
					<span>
						{l s='Proceed to checkout'}
						<i class="icon-chevron-right right"></i>
					</span>
				</button>
			</p>
		</form>
	{/if}
{else}
	<!--{if isset($account_error)}
	<div class="error">
		{if {$account_error|@count} == 1}
			<p>{l s='There\'s at least one error'} :</p>
			{else}
			<p>{l s='There are %s errors' sprintf=[$account_error|@count]} :</p>
		{/if}
		<ol>
			{foreach from=$account_error item=v}
				<li>{$v}</li>
			{/foreach}
		</ol>
	</div>
	{/if}-->
	<form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="account-creation_form" class="std box">
		{$HOOK_CREATE_ACCOUNT_TOP}
		<div class="account_creation">
			<h3 class="page-subheading">{l s='Your personal information'}</h3>
			<div class="clearfix">
				<label>{l s='Title'}</label>
				<br />
				{foreach from=$genders key=k item=gender}
					<div class="radio-inline">
						<label for="id_gender{$gender->id}" class="top">
							<input type="radio" name="id_gender" id="id_gender{$gender->id}" value="{$gender->id}" {if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id}checked="checked"{/if} />
						{$gender->name}
						</label>
					</div>
				{/foreach}
			</div>
                        <div class="required form-group">
		<script>
			
		jQuery(document).ready(function() {
    jQuery("#rut").keypress(function(tecla) {
        if(tecla.charCode ==46) return false;
    });
});
        </script>
        <!-- onkeypress="if (event.keyCode==46) event.returnValue = false;" data-validate="isDniLite" -->
                         <label for="rut">{l s='rut'} <sup>*(Formato: xxxxxxxx-x)</sup></label>
                        <input type="text"  class="is_required validate form-control" data-validate="isDniLite"   name="rut" id="rut" value="{if isset($smarty.post.rut)}{$smarty.post.rut}{/if}" />
                        
			</div>
			<div class="required form-group">
				<label for="customer_firstname">{l s='First name'} <sup>*</sup></label>
				<input onkeyup="$('#firstname').val(this.value);" type="text" class="is_required validate form-control" data-validate="isName" id="customer_firstname" name="customer_firstname" value="{if isset($smarty.post.customer_firstname)}{$smarty.post.customer_firstname}{/if}" />
			</div>
			<div class="required form-group">
				<label for="customer_lastname">{l s='Last name'} <sup>*</sup></label>
				<input onkeyup="$('#lastname').val(this.value);" type="text" class="is_required validate form-control" data-validate="isName" id="customer_lastname" name="customer_lastname" value="{if isset($smarty.post.customer_lastname)}{$smarty.post.customer_lastname}{/if}" />
			</div>
                        <div class="form-group">
                            <label for="id_state">Giro</label>
    						<select name="giro" id="giro" class="form-control">
							<option value="PPP">Persona Natural</option>
<option value= "AAR">  ADMINISTRACION AGUAS DE RIEGO</option>
 <option value= "´.-">  ASESORIAS OBRAS DE ING Y CONST</option>
 <option value= "CEM">  COMERCIALIZADORA DE MINERALES</option>
 <option value= "CVF">  COMPRAS Y VENTAS DE FERRETERIA</option>
 <option value= "CA1">  CONSTRATISTA Y SUBCONSTRATISTA OBRAS MENNORES</option>
 <option value= "-FJ">  FABRICACION DE JOYAS Y PROD CONES</option>
 <option value= "X1O">  FUNDICION DE METALES NO FERROSOS</option>
 <option value= "VCF">  PRODUCCION EN VIVEROS Y CULTIVO FRUTAL</option>
 <option value= "III">  REPARACION DE MAQUINARIA</option>
 <option value= "FFC">  SERVICIOS Y OBRAS FFCC</option>
 <option value= "TAG">  TRANSPORTE AGRICOLA</option>
 <option value= "P3I"> .PASTELERIA </option>
 <option value= "XYZ"> ´MANTENCION</option>
 <option value= "001"> ABARROTE Y BOTILLERIA</option>
 <option value= "002"> ABARROTES</option>
 <option value= "003"> ABASTECIMIENTO INDUSTRIAL</option>
 <option value= "ABM"> ABASTECIMIENTOS MINEWROS</option>
 <option value= "004"> ABOGADO</option>
 <option value= "AFO"> ABONOS FERTILIZ. Y PLANTAS ORNAM.</option>
 <option value= "AYA"> ACADEMIA Y ARRIENDO</option>
 <option value= "005"> ACCESORIOS DE AUTOMOVILES</option>
 <option value= "006"> ACCION SOCIAL</option>
 <option value= "007"> ACEROS</option>
 <option value= "AAM"> ACON</option>
 <option value= "008"> ACONDICIONAMIENTO AMBIENTAL</option>
 <option value= "ACE"> ACONDICIONAMIENTO DE EDIFICIO</option>
 <option value= "009"> ACRILICOS</option>
 <option value= "2AC"> ACTIVIDADES DEPORTIVAS </option>
 <option value= "010"> ACTIVIDADES TEATRALES</option>
 <option value= "ACU"> ACUARIOS</option>
 <option value= "011"> ACUICOLA</option>
 <option value= "012"> ACUICULTURA</option>
 <option value= "013"> ACUSTICOS</option>
 <option value= "014"> ADHESIVOS</option>
 <option value= "AD1"> ADM.Y EXPLOT.DE CENTROS DEPORT.</option>
 <option value= "OPN"> ADMIN.Y OPER. DE NAVES</option>
 <option value= "015"> ADMINISTRACION</option>
 <option value= "ABI"> ADMINISTRACION DE BIENES INMUEBLES</option>
 <option value= "ADM"> ADMINISTRACION DE COMBUSTIBLE</option>
 <option value= "016"> ADMINISTRACION PUBLICA, DEFENSA</option>
 <option value= "90A"> ADMINISTRACIONES</option>
 <option value= "017"> ADMINISTRATCION DE ALMACENES ADUANEROS</option>
 <option value= "018"> ADMIST.Y MANTENCION</option>
 <option value= "019"> AERONAUTICA</option>
 <option value= "020"> AGENCIA</option>
 <option value= "021"> AGENCIA DE ADUANA</option>
 <option value= "022"> AGENCIAS DE TURISMO </option>
 <option value= "023"> AGLOMERADOS</option>
 <option value= "024"> AGRICOLA</option>
 <option value= "026"> AGRICOLA  INDUSTRIAL Y COM.</option>
 <option value= "025"> AGRICOLA - AVICOLA</option>
 <option value= "A65"> AGRICOLA Y APICOLA</option>
 <option value= "AYC"> AGRICOLA Y COMERCIAL</option>
 <option value= "027"> AGRICOLA Y FARESTAL</option>
 <option value= "028"> AGRICOLA Y FORESTAL</option>
 <option value= "AGF"> AGRICOLA Y FRUTICOLA</option>
 <option value= "029"> AGRICOLA Y GANADERO</option>
 <option value= "030"> AGRICOLA Y OTRO</option>
 <option value= "AYP"> AGRICOLA Y PESQUERA</option>
 <option value= "031"> AGRICULTOR</option>
 <option value= "032"> AGRO INDUSTRIA</option>
 <option value= "ACO"> AGROCOMERCIAL</option>
 <option value= "ADP"> AGRODEPORTIVO</option>
 <option value= "033"> AGROINDUSTRIA</option>
 <option value= "034"> AGROINDUSTRIAL</option>
 <option value= "035"> AGROPECUARIA</option>
 <option value= "036"> AGUA POTABLE</option>
 <option value= "037"> AIRE ACONDICIONADO</option>
 <option value= "038"> AIRE ACONDICIONEDO</option>
 <option value= "Z23"> AISLACIONES </option>
 <option value= "039"> AISLANTES TERMICOS</option>
 <option value= "040"> ALARMAS</option>
 <option value= "041"> ALGODONES</option>
 <option value= "ALI"> ALIMENTACION</option>
 <option value= "ASE"> ALIMENTACION Y SERVICIOS</option>
 <option value= "APM"> ALIMENTO PARA MASCOTAS</option>
 <option value= "042"> ALIMENTOS</option>
 <option value= "043"> ALM.DIST.Y COM. DE GASES</option>
 <option value= "ASG"> ALMAC.,SECADO, EXP. GRANOS</option>
 <option value= "AIB"> ALMACENAJE Y BODEGA DE DOC.</option>
 <option value= "ADC"> ALMACENAMIENTO DE CONTENEDORES</option>
 <option value= "ALD"> ALMECENAMIENTO Y DISTRIBUCION</option>
 <option value= "A05"> ALOJAMIENTO</option>
 <option value= "A01"> ALOJAMIENTO FAMILIAR</option>
 <option value= "AL3"> ALOJAMIENTOS</option>
 <option value= "A9"> ALQUILER MAQUINARIA Y EQUIPOS</option>
 <option value= "044"> ALQUILER MAQUINAS EQUIPOS</option>
 <option value= "045"> ALUMINIO</option>
 <option value= "046"> ALUMINIOS</option>
 <option value= "047"> AMASANDERIA</option>
 <option value= "A"> AMAZANDERIA</option>
 <option value= "048"> AMBIENTAL </option>
 <option value= "AMP"> AMPLACIONES </option>
 <option value= "AMO"> AMPLIACIONES </option>
 <option value= "APL"> AMPLIFICACIONES</option>
 <option value= "AMC"> ANCLAJE MACANIZADO</option>
 <option value= "049"> ANCLAJES MECANIZADOS</option>
 <option value= "050"> ANTIGUEDADES</option>
 <option value= "051"> APICOLA</option>
 <option value= "API"> APICOLAI</option>
 <option value= "052"> APICULTURA</option>
 <option value= "053"> AQUICULTURA</option>
 <option value= "AJD"> ARCHIVOS JUDICIALES</option>
 <option value= "A12"> ARCULOS ACRILICOS</option>
 <option value= "054"> AREAS VERDES</option>
 <option value= "055"> ARIDOS</option>
 <option value= "056"> ARITUCULOS DE ASEO</option>
 <option value= "AQL"> ARQUEOLOGIA</option>
 <option value= "ACT"> ARQUITECTO</option>
 <option value= "057"> ARQUITECTURA</option>
 <option value= "058"> ARQUITECTURA Y CONST</option>
 <option value= "059"> ARQUITECTURA Y CONST.</option>
 <option value= "060"> ARQUITECTURA Y CONSTRUCCION</option>
 <option value= "AYD"> ARQUITECTURA Y DISEÑO</option>
 <option value= "061"> ARQUITECTURA Y ESPECIALIDADES</option>
 <option value= "ARQ"> ARQUITECTURA, DISEÑO Y CONSTRUCCION.</option>
 <option value= "062"> ARREND. Y ADM. DE BIENES INM.Y</option>
 <option value= "063"> ARRENDAMIENTO BIENES MUEBLES I</option>
 <option value= "064"> ARRIENDO</option>
 <option value= "065"> ARRIENDO  INGENIERIA Y CONSTR</option>
 <option value= "A1"> ARRIENDO CANCHA DEPORTIVA</option>
 <option value= "ACB"> ARRIENDO DE CABAÑAS</option>
 <option value= ".-1"> ARRIENDO DE CANCHAS</option>
 <option value= "066"> ARRIENDO DE INMUEBLES</option>
 <option value= "067"> ARRIENDO DE MAQUINARIA</option>
 <option value= "068"> ARRIENDO DE MAQUINARIAS</option>
 <option value= "1.1"> ARRIENDO DE MOLDAJES</option>
 <option value= "ADV"> ARRIENDO DE VAJILLA</option>
 <option value= "069"> ARRIENDO DE VEHICULOS</option>
 <option value= "070"> ARRIENDO EXPLOTACION B S INMUEBLES</option>
 <option value= "071"> ARRIENDO EXPLOTACION INMUEBLES</option>
 <option value= "072"> ARRIENDO Y SERVICIOS</option>
 <option value= ",.-"> ARRIENDOS</option>
 <option value= "ACF"> ARRIENDOS CANCHAS</option>
 <option value= "073"> ARRIENDOS DE EQUIPOS</option>
 <option value= "074"> ARRIENDOS PARA EVENTOS</option>
 <option value= "075"> ART. DE VESTIR</option>
 <option value= "AVI"> ART.PARA LA INDUST.DEL VINO</option>
 <option value= "S´-"> ARTE MADERA</option>
 <option value= "076"> ARTES GRAFICAS</option>
 <option value= "077"> ARTESANIA</option>
 <option value= "-Z."> ARTICULO DE DEPORTES</option>
 <option value= "AR1"> ARTICULOS DE AEÇSEO</option>
 <option value= "AR2"> ARTICULOS DE AESEO</option>
 <option value= "AR3"> ARTICULOS DE ASEO</option>
 <option value= "ADB"> ARTICULOS DE BOMBEROS</option>
 <option value= "078"> ARTICULOS DE CUERO</option>
 <option value= "079"> ARTICULOS DE FERRETERIA</option>
 <option value= "AFM"> ARTICULOS DE FIERRO Y MADERA</option>
 <option value= "ADF"> ARTICULOS DE FIESTA</option>
 <option value= "080"> ARTICULOS DE ILUMINACION</option>
 <option value= "081"> ARTICULOS DE LABORATORIO</option>
 <option value= "082"> ARTICULOS DE OFICINA</option>
 <option value= "PLV"> ARTICULOS DE PVC</option>
 <option value= "088"> ARTICULOS DE SEGURIDAD</option>
 <option value= "ADD"> ARTICULOS DENTALES</option>
 <option value= "AAD"> ARTICULOS DEPORTIVOS</option>
 <option value= "083"> ARTICULOS ELECTRICOS</option>
 <option value= "084"> ARTICULOS MEDICOS</option>
 <option value= "085"> ARTICULOS NAUTICOS</option>
 <option value= "AOT"> ARTICULOS ORTOPEDICOS</option>
 <option value= "APC"> ARTICULOS PARA CALZADO</option>
 <option value= "086"> ARTICULOS PARA EL HOGAR</option>
 <option value= "ARP"> ARTICULOS TIPICOS</option>
 <option value= "ARV"> ARTISTA VISUAL</option>
 <option value= "0AA"> ARTISTAC</option>
 <option value= "087"> ASCENSORES</option>
 <option value= "AA1"> ASENSORES</option>
 <option value= "089"> ASEO INDUSTRIAL</option>
 <option value= "ASY"> ASEO Y CONSTRUCCION</option>
 <option value= "090"> ASEO Y MANTENCION</option>
 <option value= "091"> ASERRADERO</option>
 <option value= "ACM"> ASERRADERO, CEPILLADO, FABRICACION</option>
 <option value= "092"> ASESORIA ECONOMICA, FINANCIAERA</option>
 <option value= "AEL"> ASESORIA ELECTRICA</option>
 <option value= "093"> ASESORIAS</option>
 <option value= "ASI"> ASESORIAS Y DISEÑOS</option>
 <option value= "094"> ASFALTOS</option>
 <option value= "095"> ASISTENCIA TECNICA</option>
 <option value= "096"> ASTILLEROS</option>
 <option value= "097"> ASTRONOMIA</option>
 <option value= "00A"> ASUNTOS RELIGIOSOS</option>
 <option value= "098"> AUDIOVISUALES</option>
 <option value= "099"> AUTOMATIZACION</option>
 <option value= "100"> AUTOMOTORA</option>
 <option value= "101"> AUTOMOTRIZ</option>
 <option value= "A0"> automotriz</option>
 <option value= "aut"> autopista</option>
 <option value= "102"> AVES Y SEMILLAS</option>
 <option value= "103"> AVICOLA</option>
 <option value= "104"> BAFLES</option>
 <option value= "BAL"> BALANZAS</option>
 <option value= "BA1"> BALATAS Y ACC. AUTOMOTRIZ</option>
 <option value= "105"> BANCO</option>
 <option value= "B02"> BAÑOS</option>
 <option value= "106"> BAÑOS PUBLICOS</option>
 <option value= "107"> BAÑOS TURCOS</option>
 <option value= "BAN"> BANQUETERIA</option>
 <option value= "BR"> BAR</option>
 <option value= "BAR"> BAR RESTAURANT</option>
 <option value= "108"> BARRACA</option>
 <option value= "109"> BARRACA DE FIERRO</option>
 <option value= "BYC"> BARRACA Y CONSTRUCCION</option>
 <option value= "110"> BATERIAS</option>
 <option value= "B1"> BAZAR</option>
 <option value= "112"> BAZAR ARTESANIA</option>
 <option value= "113"> BEN</option>
 <option value= "114"> BENEFICENCIA</option>
 <option value= "115"> BENEFICIENCIA</option>
 <option value= "BCC"> BICICLETAS</option>
 <option value= "BA2"> BIENES EN ARRENDAMIENTO</option>
 <option value= "116"> BIENES RAICES</option>
 <option value= "117"> BIENES RAICES</option>
 <option value= "BIS"> BISUTERIA</option>
 <option value= "118"> BODEGA</option>
 <option value= "0BB"> BODEGAJES</option>
 <option value= "119"> BOMBA HIDRAULICA</option>
 <option value= "120"> BOMBAS PARA AGUA</option>
 <option value= "X."> BORDADOS INDUSTRIALES</option>
 <option value= "121"> BOTILLERIA</option>
 <option value= "122"> BOTONERIA</option>
 <option value= "123"> BOUTIQUES</option>
 <option value= "124"> BRONCERIA</option>
 <option value= "CBÑ"> CABAÑAS</option>
 <option value= "CBM"> CABAÑAS EN MADERA</option>
 <option value= "125"> CABARET</option>
 <option value= "CBP"> CABINAS PARA PINTAR</option>
 <option value= "126"> CABÑAS</option>
 <option value= "127"> CADENA FERRETERA</option>
 <option value= "128"> CAFETERIA</option>
 <option value= "129"> CAJA COMPENSACION</option>
 <option value= "130"> CAJA DE COMPENSACION</option>
 <option value= "CJA"> CAJAS ARTESANALES</option>
 <option value= "131"> CAJAS DE ARCHIVOS</option>
 <option value= "132"> CALEFACCION</option>
 <option value= "133"> CALEFACCION</option>
 <option value= "134"> CALEFACTORES</option>
 <option value= "135"> CALZADOS</option>
 <option value= "136"> CAMPING</option>
 <option value= "137"> CAMPO DEPORTIVO</option>
 <option value= "RL1"> CANDIDATO</option>
 <option value= "138"> CAPACITACION</option>
 <option value= "CNA"> CAPTACION DE AGUAS</option>
 <option value= "139"> CAPTACION Y TRANSPORTE</option>
 <option value= "PAC"> CARABINEROS</option>
 <option value= "140"> CARNICERIA</option>
 <option value= "141"> CARPAS</option>
 <option value= "142"> CARPAS Y EVENTOS</option>
 <option value= "CME"> CARPINTERIA METALICA</option>
 <option value= "143"> CARROCERIAS</option>
 <option value= "144"> CASA DE REPOSO</option>
 <option value= "145"> CASINO</option>
 <option value= "CAU"> CAUCHO</option>
 <option value= "146"> CECINAS</option>
 <option value= "CMO"> CEMENTERIO</option>
 <option value= "147"> CENTRO DE COMPRAS</option>
 <option value= "148"> CENTRO DE DESARROLLO</option>
 <option value= "CDV"> CENTRO DE EVENTOS</option>
 <option value= "-.,"> CENTRO DEPORTIVO</option>
 <option value= "149"> CENTRO GENERAL DE PADRES</option>
 <option value= "150"> CENTRO MEDICO</option>
 <option value= "151"> CENTRO NAUTICO</option>
 <option value= "CDR"> CENTRO RECREATIVO</option>
 <option value= "152"> CER</option>
 <option value= "153"> CERAMICA</option>
 <option value= "154"> CERRAJERIA</option>
 <option value= "155"> CERTIFICACION SISTEMAS DE GESTION</option>
 <option value= "156"> CERVECERIA</option>
 <option value= "cha"> chatarra</option>
 <option value= "CHO"> CHOCOLATERIA</option>
 <option value= "157"> CIENTIFICO</option>
 <option value= "158"> CINE</option>
 <option value= "CC2"> CINE Y COMUNICACIONES</option>
 <option value= "159"> CLIMATIZACION</option>
 <option value= "160"> CLINICA</option>
 <option value= "VET"> CLINICA VETERINARIA</option>
 <option value= "161"> CLUB DEPORTIVO</option>
 <option value= "162"> CLUB SOCIAL</option>
 <option value= "163"> CODIGO RECUPERADO EL 31-Mar-04</option>
 <option value= "164"> CODIGO RECUPERADO EL 31-Mar-04</option>
 <option value= "891"> COERCIALIZADORA DE ACEROS</option>
 <option value= "165"> COERCIALIZADORA DE FRUTAS</option>
 <option value= "166"> COLEGIO</option>
 <option value= "167"> COM ARTICULOS INFANTILES</option>
 <option value= "CAF"> COM. AL POR MAYOR DE ART. DE FERRETERIA</option>
 <option value= "174"> COM. DE MAT. DE CONST/FERRE/MAD</option>
 <option value= "168"> COM. DE PROD. PARA LA MINERIA</option>
 <option value= "CPM"> COM. PROD. MINERIA E IND.</option>
 <option value= "CFS"> COM.Y FAB. DE MAT. ELECTRICOS</option>
 <option value= "169"> COMBUSTIBLES</option>
 <option value= "170"> COMER. DE INSUMO Y PROD. INDUSTRIALES</option>
 <option value= "CAC"> COMERC. AGRICOLA Y AGROPECUARIA</option>
 <option value= "171"> COMERC. SERVICIOS DE PRODUCT TECNICOS</option>
 <option value= "CIE"> COMERC., IMPÒRT. Y EXPORT.</option>
 <option value= "172"> COMERCIAL</option>
 <option value= "CEI"> COMERCIAL E INDUSTRIAL</option>
 <option value= "CEC"> COMERCIAL ELECTRONICA </option>
 <option value= "CMM"> COMERCIALEZADORA</option>
 <option value= "000"> COMERCIALIZACION</option>
 <option value= "CAG"> COMERCIALIZACION AGRICOLA Y GANADERA</option>
 <option value= "CDA"> COMERCIALIZACION DE ALIMENTOS</option>
 <option value= "COP"> COMERCIALIZACION DE PLASTICO</option>
 <option value= "CPI"> COMERCIALIZACION DE PROD. INDUST.</option>
 <option value= "173"> COMERCIALIZACION DE PRODUCTOS DEL MAR</option>
 <option value= "VCE"> COMERCIALIZACION ESTRUC. MET.</option>
 <option value= "DYY"> COMERCIALIZACION Y DISTRIBUCION </option>
 <option value= "CYD"> COMERCIALIZACION Y DISTRUBUCION </option>
 <option value= "CYS"> COMERCIALIZACION Y SERVICIO</option>
 <option value= "CRA"> COMERCIALIZADORA</option>
 <option value= "CAR"> COMERCIALIZADORA ART FERRETERIA</option>
 <option value= "892"> COMERCIALIZADORA DE ACEROS</option>
 <option value= "CEX"> COMERCIALIZADORA DE EXCEDENTES </option>
 <option value= "CMF"> COMERCIALIZADORA DE FILTROS</option>
 <option value= "CDF"> COMERCIALIZADORA DE FRUTAS</option>
 <option value= ".3-"> COMERCIALIZADORA DE INSUMOS AGRICOLA</option>
 <option value= "175"> COMERCIALIZADORA DE MADERAS</option>
 <option value= "CDM"> COMERCIALIZADORA DE MAQUINARIA</option>
 <option value= "CPA"> COMERCIALIZADORA DE PRODUC. AGROPECUARIOS</option>
 <option value= "CRI"> COMERCIALIZADORA DE REPUESTOS</option>
 <option value= "CIZ"> COMERCICIALIZACION</option>
 <option value= "176"> COMERCIO</option>
 <option value= "177"> COMERCIO EXTERIOR</option>
 <option value= "178"> COMERCIO MAYORISTA MADERAS</option>
 <option value= "CFE"> COMERZIALIZADORA Y FABRICA DE MATERIALES ELECTRICOS</option>
 <option value= "CAP"> COMIDA AL PASO</option>
 <option value= "179"> COMIDA PREPARADA</option>
 <option value= "COR"> COMIDA RAPIDA</option>
 <option value= "CBA"> COMIDAS Y BEBIDAS AL PASO</option>
 <option value= "180"> COMISIONISTA</option>
 <option value= "181"> COMPANIA MINERA</option>
 <option value= "CMD"> COMPLEJO DEPORTIVO</option>
 <option value= "CPT"> COMPLEJO TURISTICO</option>
 <option value= "s2b"> compra de exportacion de chatarra</option>
 <option value= "COV"> COMPRA VENTA</option>
 <option value= "CVQ"> COMPRA VENTA ALQ. DE INMUEBLES</option>
 <option value= "182"> COMPRA VENTA ART FERRETERIA</option>
 <option value= "CVP"> COMPRA VENTA DE PLANTAS</option>
 <option value= "VM"> COMPRA VENTA METALES </option>
 <option value= "C01"> COMPRA VENTA METALES MINERALES</option>
 <option value= "PMI"> COMPRA VENTA PROD.INDUST.</option>
 <option value= "CVR"> COMPRA VENTA REPUESTOS</option>
 <option value= "183"> COMPRA Y VENTA</option>
 <option value= "CYV"> COMPRA Y VENTA  ART. COMPUTACION</option>
 <option value= "184"> COMPRA Y VENTA ART FERRETERIA</option>
 <option value= "CD1"> COMPRA Y VENTA DE ACCESORIOS AUTOMOTRICES</option>
 <option value= "ALG"> COMPRA Y VENTA DE ALGAS</option>
 <option value= "CVA"> COMPRA Y VENTA DE ANIMALES</option>
 <option value= "CY2"> COMPRA Y VENTA DE CONTENEDORES </option>
 <option value= "CO2"> COMPRA Y VENTA DE MONEDA EXTRANJERA</option>
 <option value= "CVC"> COMPRA Y VENTA DE PROD. AGRICOLAS</option>
 <option value= "CVI"> Compra y Venta de productos para la Industria y Minería</option>
 <option value= "ALE"> COMPRA Y VTA ALEVINES </option>
 <option value= "VM1"> COMPRA Y VTA MATERIALES DE CONSTRUCCION</option>
 <option value= "CVM"> COMPRAVENTA MAQUINARIAS</option>
 <option value= "185"> COMPRE Y VENTA DE PLASTICO</option>
 <option value= "186"> COMPRESORES</option>
 <option value= "CCU"> COMPUESTO DE CAUCHO</option>
 <option value= "187"> COMPUTACION</option>
 <option value= "X-."> COMUNICACCIONES</option>
 <option value= "188"> COMUNICACIONES</option>
 <option value= "189"> COMUNIDAD</option>
 <option value= "190"> CONCESIONES</option>
 <option value= "CON"> CONDAMINIO</option>
 <option value= "CO1"> CONDOMINIO</option>
 <option value= "191"> CONDUCTORES ELECTRICOS</option>
 <option value= "CCC"> CONFECCION</option>
 <option value= "192"> CONFECCION DE POZOS</option>
 <option value= "193"> CONFECCION Y VENTA DE VESTUARI</option>
 <option value= "194"> CONFECCIONES</option>
 <option value= "195"> CONFECCIONES TEXTILES</option>
 <option value= "196"> CONFITERIA</option>
 <option value= "197"> CONS</option>
 <option value= "198"> CONS EXP CARRETERAS Y PEAJES</option>
 <option value= "CI"> CONSECIONARIO INTEGRAL</option>
 <option value= "199"> CONSERVADOR DE BIENES RAICES</option>
 <option value= "10K"> CONSERVAS</option>
 <option value= "200"> CONSERVERA</option>
 <option value= "GSM"> CONST. GALP. / SOLUCIONES MOD.</option>
 <option value= "CO"> CONSTRATISTA</option>
 <option value= "CCM"> CONSTRATISTA EN CONSTRUCCION</option>
 <option value= "CM1"> CONSTRATISTA OBRAS MENORES Y CIVILES</option>
 <option value= "201"> CONSTRUCCION</option>
 <option value= "202"> CONSTRUCCION DE EQUIPOS IND.</option>
 <option value= "A1A"> CONSTRUCCION DE RIEGO Y JARDINES</option>
 <option value= "CV2"> CONSTRUCCION DE VIVIENDA</option>
 <option value= "COB"> CONSTRUCCION OBRAS CIVILES</option>

 <option value= "OMN"> CONSTRUCCION OBRAS MENORES </option>
 <option value= "203"> CONSTRUCCION Y MONTAJE</option>
 <option value= "CYP"> CONSTRUCCION Y PAISAJISMO</option>
 <option value= "CYR"> CONSTRUCCION Y REFRIGERACION</option>
 <option value= "204"> CONSTRUCCION Y TRANSPORTE</option>
 <option value= "CTR"> CONSTRUCCIONES</option>
 <option value= "CEL"> CONSTRUCCIONES ELECTRICAS</option>
 <option value= "CEE"> CONSTRUCCIONES ELECTROMECANICAS</option>
 <option value= "CM"> CONSTRUCCIONES MENORES</option>
 <option value= "205"> CONSTRUCTOR</option>
 <option value= "C11"> CONSTRUCTOR CIVIL</option>
 <option value= "206"> CONSTRUCTORA</option>
 <option value= "207"> CONSTRUCTORES</option>
 <option value= "208"> CONSULTA MEDICA</option>
 <option value= "CCX"> CONSULTERIA</option>
 <option value= "209"> CONSULTORES</option>
 <option value= "RIA"> CONSULTORIA</option>
 <option value= "EDU"> CONSULTORIA Y SERVICIOS EN EDUCACION</option>
 <option value= "210"> CONSULTORIO</option>
 <option value= "0A2"> CONT. Y SUB CONT. OBRAS MENORES</option>
 <option value= "CTD"> CONTABILIDAD</option>
 <option value= "211"> CONTRATISTA</option>
 <option value= "212"> CONTRATISTA</option>
 <option value= "CO9"> CONTRATISTA EN CONSTR. Y OBRAS MENORES</option>
 <option value= "ETM"> CONTRATISTA EN ESTRUCT. METALICAS</option>
 <option value= "CI1"> CONTRATISTA EN INSTALACION ELECTRICA</option>
 <option value= "COC"> CONTRATISTA EN OBRAS CIVILES</option>
 <option value= "CM3"> CONTRATISTA MARITIMO</option>
 <option value= "213"> CONTRATISTA MARITIMO INDUSTRIAL</option>
 <option value= "214"> CONTROL DE CALIDAD</option>
 <option value= "CPL"> CONTROL DE PLAGA</option>
 <option value= "215"> CONTROL DE PLAGAS</option>
 <option value= "CMT"> CONTRUCCIONES METALICAS</option>
 <option value= "CXX"> CONVERSIONES </option>
 <option value= "CA-"> CONVERSIONES AUTOMOTRIZES</option>
 <option value= "COO"> COOPERATIVA</option>
 <option value= "216"> COOPERATIVA DE CONSUMO</option>
 <option value= "217"> CORPORACION</option>
 <option value= "218"> CORPORACION DEPORTIVA</option>
 <option value= "C"> CORRE</option>
 <option value= "219"> CORREDORES DE PROPIEDADES</option>
 <option value= "220"> CORREO</option>
 <option value= "1CO"> CORREO PRIVADO</option>
 <option value= "221"> CORRESPONDENCIA</option>
 <option value= "222"> CORRETAJE DE GANADO</option>
 <option value= "CDP"> CORRETAJE DE PROD. AGRICOLAS</option>
 <option value= "CRC"> CORRETAJE Y CONSTRUCCION</option>
 <option value= "C1"> CORRIENTE DEBILES</option>
 <option value= "C23"> CORTEMETAL</option>
 <option value= "TES"> CORTES</option>
 <option value= "C2"> CORTINAJES DECORACION</option>
 <option value= "223"> CORTINAS METALICAS</option>
 <option value= "CIN"> COSINA INDUSTRIAL</option>
 <option value= "224"> COSMETICA</option>
 <option value= "CT"> COSTURAS</option>
 <option value= "CTI"> COSTURAS INDUSTRIALES</option>
 <option value= "225"> CREDITO PRENDARIO</option>
 <option value= "226"> CRIA DE ANIMALES</option>
 <option value= "CGB"> CRIA DE GANADO BOBINO</option>
 <option value= "XX1"> CRIADERO</option>
 <option value= "227"> CRIADERO ANIMALES</option>
 <option value= "228"> CRIADERO DE AVES</option>
 <option value= "229"> CRIANZA</option>
 <option value= "230"> CRIANZA DE AVESTRUZ</option>
 <option value= "231"> CRIANZA Y ENGORDA DE ANIMALES</option>
 <option value= "232"> CRISTALERIA</option>
 <option value= "233"> CROMADOS INDUSTRIALES</option>
 <option value= "234"> CROMADOS Y MUEBLES</option>
 <option value= "C1P"> CULIVO HIDROPONICOS</option>
 <option value= "235"> CULTIVO ARANDANO</option>
 <option value= "236"> CULTIVO ARBOLES FRUTALES</option>
 <option value= "BBB"> CULTIVO DE PLANTAS</option>
 <option value= "CPV"> CULTIVO DE PLANTAS VIVAS </option>
 <option value= "CVS"> CULTIVO DE SALMONES</option>
 <option value= "CLH"> CULTIVOS HIDROPONICOS</option>
 <option value= "CMA"> CULTIVOS MARINOS</option>
 <option value= "237"> CULTIVOS Y EXP. DE ESPECIES HIDROBIOLOGICAS</option>
 <option value= "238"> CULTURA INTEGRAL</option>
 <option value= "239"> CURTIEMBRE</option>
 <option value= "240"> CURTIEMBRES</option>
 <option value= "241"> DECORACION</option>
 <option value= "DCR"> DECORACIONES </option>
 <option value= "def"> Defensa</option>
 <option value= "242"> DEMOLICION</option>
 <option value= "243"> DEMOLICIONES</option>
 <option value= "244"> DENTAL</option>
 <option value= "DAB"> DEP. DE ABASTECIMIENTO</option>
 <option value= "DEO"> DEPORTE</option>
 <option value= "245"> DEPORTES</option>
 <option value= "DYE"> DEPORTES YY EVENTOS</option>
 <option value= "246"> DEPOSITO DE LANAS</option>
 <option value= "247"> DEPOSITO Y ALMACENAMIENTO</option>
 <option value= "DPL"> DERIVADOS DEL PETROLEO</option>
 <option value= "DDD"> DESABOLLADURA</option>
 <option value= "248"> DESARMADURIA</option>
 <option value= "DPE"> DESAROLLO DE PROYECTOS ELECTRICOS</option>
 <option value= "DPN"> DESARROLLO</option>
 <option value= "249"> DESARROLLO DE INNOVACION TECNOLOGICA</option>
 <option value= "DPM"> DESARROLLO PRODUCTOS NATURALES</option>
 <option value= "250"> DESHIDRATADOS</option>
 <option value= "DGT"> DETERGENTES</option>
 <option value= "DI"> di</option>
 <option value= "251"> DIBUJANTE TECNICO</option>
 <option value= "DTC"> DICTRIBUIDORA Y COMERCIALIZADORA</option>
 <option value= "DIP"> DIPUTADO</option>
 <option value= "252"> DIS Y COM DE GAS Y OTROS COMBU</option>
 <option value= "0-1"> DISCOTECA</option>
 <option value= "253"> DISCOTEQUE</option>
 <option value= "+DI"> DISEÑADOR</option>
 <option value= "254"> DISEÑO</option>
 <option value= "255"> DISEÑO ARQUITECTURA Y DECORACION</option>
 <option value= "256"> DISEÑO PUBLICIDAD COMPRA Y VENTA</option>
 <option value= "257"> DISEÑO Y CONSTRUCCION </option>
 <option value= "DYF"> DISEÑO Y FABRICACION</option>
 <option value= "258"> DISEÑOS</option>
 <option value= "259"> DISQUERIA</option>
 <option value= "aaa"> dist</option>
 <option value= "260"> DIST MATERIALES CONSTRUCCION</option>
 <option value= "261"> DIST NEUMATICOS PRODUCTOS IND</option>
 <option value= "262"> DIST Y VENTA ENERGIA ELECTRICA</option>
 <option value= "DPF"> DIST. DE PROD.FERRETERIA,LIBRERIA Y ASEO</option>
 <option value= "DAS"> DIST.ART.DE SEGURIDAD</option>
 <option value= "DCP"> DIST.Y CAPTACION Y PURIFICACION</option>
 <option value= "263"> DISTRBUIDORA PRODUCTOS DEL MAR </option>
 <option value= "DDC"> DISTRIB. DE COMBUSTIBLE</option>
 <option value= "DDE"> DISTRIBUCION DE EMBALAJES</option>
 <option value= "DPI"> DISTRIBUCION DE PRODUCTOS IND</option>
 <option value= "DSG"> DISTRIBUCION Y SERVICIOS GENERALES</option>
 <option value= "DYM"> DISTRIBUCUION Y VENTA DE MAQUINARIA</option>
 <option value= "264"> DISTRIBUIDOR</option>
 <option value= "PX"> DISTRIBUIDOR</option>
 <option value= "00M"> DISTRIBUIDOR DE AGUAS DE RIEGO</option>
 <option value= "MET"> DISTRIBUIDOR DE PROD.METALICOS</option>
 <option value= "dee"> distribuidor energia electrica</option>
 <option value= "265"> DISTRIBUIDOR MATERIALES CONTR</option>
 <option value= "DIS"> DISTRIBUIDORA DE ALIMENTOS</option>
 <option value= "DDG"> DISTRIBUIDORA DE GAS</option>
 <option value= "DLF"> DISTRIBUIDORA DE LEÑA Y FERRET.</option>
 <option value= "DVL"> DISTRIBUIDORA DE VINOS</option>
 <option value= "266"> DISTRYBUCION Y REPRESENTACIONES</option>
 <option value= "267"> DULCERIA</option>
 <option value= "DDA"> DULCES</option>
 <option value= "ECT"> ECU</option>
 <option value= "ECE"> ECUESTRE</option>
 <option value= "268"> EDICIONES</option>
 <option value= "269"> EDITORIAL</option>
 <option value= "EDI"> EDITORIAS</option>
 <option value= "270"> EDUCACION</option>
 <option value= "EEF"> EFICIENCIA ENERGETICA</option>
 <option value= "271"> EJECUCION DE PROYECTOS</option>
 <option value= "272"> EJERCITO</option>
 <option value= "277"> ELAB. BEBIDAS MALT. CERV. Y MALTAS</option>
 <option value= "273"> ELAB. DE PRODUCTOS DEL MAR</option>
 <option value= "COM"> ELAB. Y COMER. DE RESINAS UREICAS</option>
 <option value= "274"> ELAB.COM.PROD.ALIM. Y AGR.</option>
 <option value= "275"> ELAB.Y VTA.DE CONS.Y PROD.ALIM</option>
 <option value= "846"> ELABORACION ARTESANAL DE TRIGO DESHIDRATADO</option>
 <option value= "276"> ELABORACION DE ALIMENTOS PARA MASCOTAS</option>
 <option value= "278"> ELABORACION DE CERVEZA</option>
 <option value= "279"> ELABORACION DE CREMAS Y JABONES</option>
 <option value= "EL"> ELABORACION DE DETERGENTES INDUSTRIALES</option>
 <option value= "EPM"> ELABORACION DE PRODUCTOS DEL MAR</option>
 <option value= "EMD"> ELABORACION MADERAS</option>
 <option value= "PAL"> ELABORACION Y VENTA PROD. ALIM.</option>
 <option value= "280"> ELABORADORA</option>
 <option value= "281"> ELABORADORA DE ALIMENTOS</option>
 <option value= "ELA"> ELABORADORA DE METALES</option>
 <option value= "EDV"> ELABORADORA DE VINOS</option>
 <option value= "AHO"> ELABY COM. DE PROD METAL DESPLEGADO</option>
 <option value= "282"> ELEBORACION DE PROD. ALIMENTICIOS</option>
 <option value= "EYC"> ELECT.Y CONSTRUCCION</option>
 <option value= "283"> ELECTRICIDAD</option>
 <option value= "MEL"> ELECTRICIDAD</option>
 <option value= "284"> ELECTRICIDAD DIESEL Y MAQUINARIA</option>
 <option value= "EI"> ELECTRICIDAD INDUSTRIAL</option>
 <option value= "285"> ELECTRODOMESTICOS</option>
 <option value= "286"> ELECTROMECANICA</option>
 <option value= "E01"> ELECTROMECANICA Y OTROS</option>
 <option value= "287"> ELECTRONICA</option>
 <option value= "ECV"> ELEMENTOS DE COMUN. VISUAL</option>
 <option value= "EF"> ELEMENTOS DE REFRIGERACION</option>
 <option value= "288"> EMBAJADA</option>
 <option value= "EMB"> EMBALAJES</option>
 <option value= "289"> EMBARCADORES INTERNACIONALES</option>
 <option value= "EBS"> EMBASADOS</option>
 <option value= "Z-."> EMBAZADORA</option>
 <option value= "290"> EMBOTELLADORA</option>
 <option value= "291"> EMPACADORA</option>
 <option value= "292"> EMPANADAS FAMOSAS</option>
 <option value= "293"> ENCUADERNACION</option>
 <option value= "294"> ENERGIA</option>
 <option value= "EAT"> ENERGIA ALTERNATIVA</option>
 <option value= "ESO"> ENERGIA SOLAR</option>
 <option value= "E02"> ENMARCACIONES</option>
 <option value= "295"> ENTRETENCION</option>
 <option value= "296"> ENTRETENCIONES</option>
 <option value= "ETT"> ENTRETENIMIENTO</option>
 <option value= "297"> ENVASADORA</option>
 <option value= "298"> ENVASES</option>
 <option value= "299"> ENVASES DE MADERA Y OTRO</option>
 <option value= "PLA"> ENVASES PLASTICOS</option>
 <option value= "01"> EQUIPAMIENTO AUDIOVISUAL</option>
 <option value= "300"> EQUIPAMIENTOS</option>
 <option value= "301"> EQUIPOS CONTRA INCENDIO</option>
 <option value= "EDB"> EQUIPOS DE BOMBEO</option>
 <option value= "302"> EQUIPOS DE LABORATORIOS</option>
 <option value= "303"> EQUIPOS DE OFICINA</option>
 <option value= "EDR"> EQUIPOS DE RIEGO</option>
 <option value= "EDS"> EQUIPOS DE SEGURIDAD</option>
 <option value= "304"> EQUIPOS E INSUMOS DE LABORATORIO CONTRATISTA Y SUBCONTRATIST</option>
 <option value= "EEE"> EQUIPOS ELECTRONICOS</option>
 <option value= "EQG"> EQUIPOS GASTRONOMICOS</option>
 <option value= "305"> EQUIPOS IDRAULICOS</option>
 <option value= "306"> EQUIPOS INDUSTRIALES</option>
 <option value= "EQT"> EQUIPOS TERMICOS</option>
 <option value= "307"> ESCAPES</option>
 <option value= "308"> ESCENOGRAFIA</option>
 <option value= "309"> ESCUELA LA PARVA EDUCACION</option>
 <option value= "310"> ESCULTOR</option>
 <option value= "ERA"> ESCULTURA</option>
 <option value= "311"> ESPECTACULOS</option>
 <option value= "C1A"> ESPORTADOR DE FRUTOS</option>
 <option value= "EOI"> EST.DE OBRAS DE ING.EN R.N.</option>
 <option value= "312"> ESTABLECIMIENTO EDUCACIONAL</option>
 <option value= "313"> ESTACION DE SERVICIO</option>
 <option value= "314"> ESTACION DE SERVICIOS</option>
 <option value= "315"> ESTACIONAMIENTO</option>
 <option value= "316"> ESTAMPADOS</option>
 <option value= "EMT"> ESTAMPADOS METALICOS </option>
 <option value= "TAT"> ESTATAL</option>
 <option value= "317"> ESTRUCTURA ALUMINIO</option>
 <option value= "318"> ESTRUCTURA Y MONTAJE</option>
 <option value= "EST"> ESTRUCTURAS</option>
 <option value= "319"> ESTRUCTURAS METALICAS</option>
 <option value= "E2O"> ESTRUCTURAS Y MONTAJE</option>
 <option value= "320"> ESTUDIO</option>
 <option value= "ESJ"> ESTUDIO JURIDICO</option>
 <option value= "321"> ESTUDIO Y CACITACION</option>
 <option value= "EBG"> ESTUDIOS BIOLOGICOS MARINO</option>
 <option value= "322"> EVENTOS</option>
 <option value= "EDP"> EVENTOS DEPORTIVOS</option>
 <option value= "EXD"> EXCEDENTES </option>
 <option value= "323"> EXCEDENTES INDUSTRIAL</option>
 <option value= "324"> EXCEDENTES INDUSTRIALES</option>
 <option value= "-.1"> EXEDENTE MATERIALES DE CONSTRUCCION</option>
 <option value= "EXI"> EXEDENTES INDUSTRIALES</option>
 <option value= "X.-"> EXIBIDORES</option>
 <option value= "325"> EXP. AGR. GANADERA FORESTAL</option>
 <option value= "326"> EXPLOSIVOS INDUSTRIALES</option>
 <option value= "327"> EXPLOT Y COMERC ESP ACUICOLAS</option>
 <option value= "EAM"> EXPLOT. DE ARIDOS Y MOV. DE TIERRA</option>
 <option value= "328"> EXPLOT. EJEC. Y CONST. DE OBRAS PUBLI</option>
 <option value= "329"> EXPLOTACION AGRICOLA</option>
 <option value= "EBM"> EXPLOTACION BIENES Y MUEBLES</option>
 <option value= "330"> EXPLOTACION DE ANDARIVELES</option>
 <option value= "331"> EXPLOTACION DE BOSQUES</option>
 <option value= "exm"> EXPLOTACION DE OTRAS MINASY CANTERAS NCP</option>
 <option value= "EPA"> EXPLOTACION DE PREDIOS AGRICOLAS</option>
 <option value= "844"> EXPLOTACION DE YACIMIENTOS MINEROS</option>
 <option value= "332"> EXPLOTACION GANADERA</option>
 <option value= "333"> EXPLOTACION IND DE MADERAS</option>
 <option value= "EXP"> EXPLOTACION INDUSTRIA PESQUERA</option>
 <option value= "EMC"> EXPLOTACION MINERA,CANTERAS Y OTROS</option>
 <option value= "exn"> explotacion NAVIERA</option>
 <option value= "334"> EXPORTACION DE METALES</option>
 <option value= "EEG"> EXPORTACION GANADO</option>
 <option value= "EPT"> EXPORTACIONES</option>
 <option value= "335"> EXPORTADOR</option>
 <option value= "EDF"> EXPORTADOR DE FRUTA</option>
 <option value= "EX"> EXPORTADORA</option>
 <option value= "336"> EXPOSICION</option>
 <option value= "337"> EXTINTORES</option>
 <option value= "F14"> EXTRACCION</option>
 <option value= "F15"> EXTRACCION DE COBRE</option>
 <option value= "EXT"> EXTRACCION PIEDRA Y ARCILLA</option>
 <option value= "338"> EXTRACION DERECIDUOS</option>
 <option value= "339"> EXTRUCTURAS</option>
 <option value= "FPQ"> FAB .Y COM. PRODUCTOS QUIMICOS</option>
 <option value= "F01"> FAB ALIMENTOS Y CHOC</option>
 <option value= "340"> FAB BEBIDAS ANALCOHOLICAS Y OT</option>
 <option value= "C3"> FAB DE DETER Y CONSTRUCCION</option>
 <option value= "341"> FAB PRODUCTOS LACTEOS</option>
 <option value= "342"> FAB REPARACION REPUESTOS IND</option>
 <option value= "343"> FAB Y COMERC DE CIGARRILLOS</option>
 <option value= "344"> FAB Y VENTA PAPELES Y CARTONES</option>
 <option value= "345"> FAB, Y MANTENCION DE EQUIPOS</option>
 <option value= "346"> FAB. DE ABONOS Y COMP. DE NITROGENO</option>
 <option value= "FAA"> FAB. DE ALIMENTOS PREP. PARA ANIMAL</option>
 <option value= "347"> FAB. DE MALTA Y CERVEZA</option>
 <option value= "FAI"> FAB. DE MAQUIN.ACERO INOX.</option>
 <option value= "348"> FAB. DE MAQUINAS Y EQUIPOS</option>
 <option value= "FPM"> FAB. DE PERNOS, MAESTRANZA Y METALURGICA</option>
 <option value= "359"> FAB. DE PROD. DE METAL N.C.P.</option>
 <option value= "FIE"> FAB. IMP. EXP. DE PROD. METALICOS</option>
 <option value= "349"> FAB. PROD. MIN. NO METALICOS</option>
 <option value= "350"> FAB. Y COM. DE PISOS Y ALFOMBRAS</option>
 <option value= "351"> FAB. Y MONTAJES DE EQUIPOS</option>
 <option value= "352"> FAB.DE CEMENTO Y CAL</option>
 <option value= "888"> FAB.DE ESTANQUES Y EST.MET.</option>
 <option value= "TPV"> FAB.DE TERMOPANELES DE VIDRIO</option>
 <option value= "353"> FABRICA</option>
 <option value= "FMO"> FABRICA  MONTAJES Y OO CIVILES </option>
 <option value= "354"> FABRICA DE ACUARIOS</option>
 <option value= "FAD"> FABRICA DE ARTICULOS DEPORTIVOS</option>
 <option value= "355"> FABRICA DE ARTICULOS PARA ENCUADERNACION</option>
 <option value= "FA1"> FABRICA DE ASFALTOS</option>
 <option value= "356"> FABRICA DE ASIENTOS DE WC</option>
 <option value= "840"> Fábrica de Azúcar y Edulcorantes</option>
 <option value= "842"> Fábrica de Azúcar y otros</option>
 <option value= "357"> FABRICA DE BEBIDAS ANALCOHOLICAS</option>
 <option value= "FBA"> FABRICA DE BOTONES Y ART.PLASTICOS</option>
 <option value= "358"> FABRICA DE CALZADO</option>
 <option value= "FCA"> FABRICA DE CAUCHO</option>
 <option value= "360"> FABRICA DE CELULOSA</option>
 <option value= "361"> FABRICA DE CEMENTO</option>
 <option value= "F1"> FABRICA DE CHOCOLATES</option>
 <option value= "FCE"> FABRICA DE CONDUCTORES ELECTRICOS</option>
 <option value= "FDC"> FABRICA DE CONFITES</option>
 <option value= "DET"> FABRICA DE DETERGENTES</option>
 <option value= "FDD"> FABRICA DE DULCES</option>
 <option value= "FE1"> FABRICA DE EMPANADAS</option>
 <option value= "FDE"> FABRICA DE EMPAQUETADURA</option>
 <option value= "362"> FABRICA DE ENVASES</option>
 <option value= "FEV"> FABRICA DE ENVASES DE VIDRIO</option>
 <option value= "FEM"> FABRICA DE EQUIPOS MINEROS</option>
 <option value= "363"> FABRICA DE GALLETAS Y CONFITES</option>
 <option value= "364"> FABRICA DE HIELO</option>
 <option value= ".-2"> FABRICA DE LAMPARAS</option>
 <option value= "365"> FABRICA DE MALLAS</option>
 <option value= "FDM"> FABRICA DE MANGUERAS</option>
 <option value= "FBM"> FABRICA DE MAQUINARIA</option>
 <option value= "FIM"> FABRICA DE MAQUINARIA INDUSTRIAL</option>
 <option value= "MEZ"> FABRICA DE MEZCLAS AROMATICAS</option>
 <option value= "MOR"> FABRICA DE MORTEROS</option>
 <option value= "366"> FABRICA DE MUEBLES</option>
 <option value= "FP"> FABRICA DE PAN DE PASCUA</option>
 <option value= "FBP"> FABRICA DE PERNOS</option>
 <option value= "367"> FABRICA DE PINTURAS</option>
 <option value= "368"> FABRICA DE PIZARRAS</option>
 <option value= "369"> FABRICA DE PLASTICOS</option>
 <option value= "FDR"> FABRICA DE REDES</option>
 <option value= "FDS"> FABRICA DE SILENCIADORES</option>
 <option value= "FTS"> FABRICA DE TROQUELADOS DE SUELAS</option>
 <option value= "370"> FABRICA DE TUBOS Y CAÑERIAS</option>
 <option value= "FPE"> FABRICA DEP ROD.NCP</option>
 <option value= "FMM"> FABRICA MUEBLES METALICOS</option>
 <option value= "371"> FABRICA Y COMERCIALIZADORA</option>
 <option value= "FYC"> FABRICACIO Y CONSTRUCCION</option>
 <option value= "FFF"> FABRICACION</option>
 <option value= "FA2"> FABRICACION ART. DE METAL</option>
 <option value= "373"> FABRICACION DE ARTICULOS EN CEMENTO</option>
 <option value= "FSD"> FABRICACION DE DUCTOS</option>
 <option value= "FEQ"> FABRICACION DE EQUIPOS</option>
 <option value= "FEE"> FABRICACION DE EQUIPOS ELECTRICOS</option>
 <option value= "FIP"> FABRICACION DE IMPLEMENTOS DE PROTECCION</option>
 <option value= "374"> FABRICACION DE INSTRUMENTOS CIENTIFICOS</option>
 <option value= "FMI"> FABRICACION DE MAQUINARIA AGROINDUSTRIAL</option>
 <option value= "FMA"> FABRICACION DE MAQUINARIA AGROPECUARIA</option>
 <option value= "FM"> FABRICACION DE MAQUINARIA AGROPECUARIAL</option>
 <option value= "0.1"> FABRICACION DE PIEZAS</option>
 <option value= "MAD"> FABRICACION DE PROD. DE MADERA</option>
 <option value= "375"> FABRICACION DE PULPA DE MADERA</option>
 <option value= "376"> FABRICACION DE PULPA MADERA</option>
 <option value= "FDV"> FABRICACION DE VALVULAS</option>
 <option value= "01X"> FABRICACION I COMERCIALIZACION</option>
 <option value= "FME"> FABRICACION MONTAJE DE EXTRUCTURAS</option>
 <option value= "FPP"> FABRICACION PERFILES</option>
 <option value= "377"> FABRICACION PROD. DE FIBROCEMENTOS</option>
 <option value= "378"> FABRICACION PRODUCTOS MADERA</option>
 <option value= "fp1"> fabricacion productos metalicos</option>
 <option value= "FAB"> FABRICACION Y COMERCIALIZACION</option>
 <option value= "FIC"> FABRICACION Y CONSTRUCCION</option>
 <option value= "379"> FABRICACION Y DIST.</option>
 <option value= "380"> fabricacion y mantencion industrial</option>
 <option value= "FAM"> FABRICACION Y MONTAJE</option>
 <option value= ".12"> FABRICACION Y MONTAJE IND.</option>
 <option value= "381"> FABRICACION Y REPARACION</option>
 <option value= "382"> FABRICACION Y VENTA CARBONATO DE CALCIO </option>
 <option value= "383"> FABRICACIONES METALICAS</option>
 <option value= "384"> FABRICANTE DE CONDUCTORES ELECTRICOS</option>
 <option value= "385"> FARMACIA</option>
 <option value= "387"> FCA DE TEJIDO</option>
 <option value= "388"> FCA Y VENTA DE TRANSFORMADORES</option>
 <option value= "389"> FCA Y VENTAS PRODUCTOS TISSUE</option>
 <option value= "FA3"> FCA. DE MATERIALES PARA LA CONSTRUCCION</option>
 <option value= "372"> FCA. DE PAPELES Y CARTONES.</option>
 <option value= "390"> FCA. DE TUBOS  BALDOSAS Y MATE</option>
 <option value= "FOM"> FCA. OXIDO MOLIB. FERROMOLIB. Y RENIO</option>
 <option value= "391"> FCA. PERNOS TUERCAS TORNILLOS</option>
 <option value= "392"> FCA. Y VENTA DE TRANSFORMADORS</option>
 <option value= "393"> FCA.DE RADIADORES</option>
 <option value= "FFE"> FERIAS Y EXPOSICIONES</option>
 <option value= "394"> FERRETERIA</option>
 <option value= "395"> FERRETERIA INDUSTRIAL</option>
 <option value= "396"> FERRETERIA Y BARRACA</option>
 <option value= "FVC"> FERRETERIA Y MAT.DE CONSTRUCCION</option>
 <option value= "397"> FERRETERIA Y MATERIALES DE CON</option>
 <option value= "398"> FERRETERIA Y SERVICIOS</option>
 <option value= "FER"> FERTILIZANTES</option>
 <option value= "399"> FIAMBRERIA</option>
 <option value= "FBR"> FIBRA</option>
 <option value= "400"> FIBRA VIDRIO</option>
 <option value= "401"> FIBRAS</option>
 <option value= "FTR"> FILTRO</option>
 <option value= "SS1"> FILTROS</option>
 <option value= "403"> FISCAL</option>
 <option value= "404"> FLORERIA</option>
 <option value= "FTN"> FORESTACION</option>
 <option value= "405"> FORESTAL</option>
 <option value= "FAC"> FORESTAL AGRICOLA</option>
 <option value= "406"> FORJA</option>
 <option value= "407"> FOTOGRABADO YLITOGRAFIA</option>
 <option value= "408"> FOTOGRAFIA</option>
 <option value= "409"> FOTOGRAFIA PUBLICITARIA</option>
 <option value= "FYD"> FOTOGRAFIA Y DECORACION</option>
 <option value= "FMC"> FOTOMECANICA</option>
 <option value= "402"> FRIGORIFICO</option>
 <option value= "410"> FRIGORIFICO</option>
 <option value= "411"> FRIGPRIFICO</option>
 <option value= "412"> FRUTA Y VERDURA</option>
 <option value= "413"> FRUTALES</option>
 <option value= "414"> FRUTALES Y MOVIMIENTO DE TIERRA</option>
 <option value= "415"> FRUTAS Y VERDURAS</option>
 <option value= "416"> FRUTICOLA</option>
 <option value= "417"> FRUTICOLA Y GANADERA</option>
 <option value= "418"> FRUTOS DEL PAIS</option>
 <option value= "419"> FUENTE DE SODA</option>
 <option value= "420"> FUENTE SODA</option>
 <option value= "421"> FUERZAS ARMADAS</option>
 <option value= "422"> FUMIGACION</option>
 <option value= "423"> FUMIGACIONES</option>
 <option value= "424"> FUNDACION</option>
 <option value= "425"> FUNDICION</option>
 <option value= "426"> FUNDICION Y MAESTRANZA</option>
 <option value= "FUN"> FUNDO</option>
 <option value= "427"> FUNERARIA</option>
 <option value= "GDA"> GALERIA DE ARTE</option>
 <option value= "428"> GALVANOPLASTIA</option>
 <option value= "429"> GANADERIA</option>
 <option value= "GGG"> GARAGE</option>
 <option value= "430"> GARAJE</option>
 <option value= ".03"> GASES INDUSTRIALES</option>
 <option value= ".02"> GASESA INDUSTRIALES</option>
 <option value= "431"> GASFITERIA</option>
 <option value= "432"> GASTRONOMIA</option>
 <option value= "GEN"> GENERACION ELECTRICA</option>
 <option value= "GEE"> GENERACION ENERGIA</option>
 <option value= "433"> GENERADORA Y DIST ELECTRICIDAD</option>
 <option value= "GAQ"> GEO ARQUEOLOGIA</option>
 <option value= "434"> GESTIO AUTOVIAS Y AUTOPISTAS</option>
 <option value= "435"> GESTION  AUTOVIAS Y AUTOPISTAS</option>
 <option value= "GTI"> GESTION INMOBILIARIA</option>
 <option value= "GA"> GESTION Y ARTE</option>
 <option value= "2.M"> GIMNASIO</option>
 <option value= "436"> GOMA</option>
 <option value= "437"> GRABADOS</option>
 <option value= "438"> GRAFICA</option>
 <option value= "GM"> GRAN MINERIA DEL COBRE</option>
 <option value= "439"> GRAN TIENDA</option>
 <option value= "440"> GRANDES TIENDAS</option>
 <option value= "441"> GRANJA EDUCATIVA</option>
 <option value= "gfe"> granja familiar y eventos</option>
 <option value= "442"> GRUAS</option>
 <option value= "443"> HABITACIONAL</option>
 <option value= "HEL"> HELADOS</option>
 <option value= "444"> Helicicultura</option>
 <option value= "HEV"> HERRAMIENTAS ABARROTES Y VARIOS</option>
 <option value= "445"> HIDRAULICOS</option>
 <option value= "446"> HIDROELECTRICA</option>
 <option value= "HPI"> HIDROPONIA</option>
 <option value= "HL"> HILANDERIA</option>
 <option value= "447"> HIPODROMO</option>
 <option value= "448"> HIPODROMOS</option>
 <option value= "449"> HOGAR</option>
 <option value= "450"> HOJALATERIA</option>
 <option value= "451"> HORMIGON</option>
 <option value= "452"> HORMIGONES</option>
 <option value= "453"> HOSPEDAJE</option>
 <option value= "454"> HOSPITAL</option>
 <option value= "H1"> HOSTAL</option>
 <option value= "455"> HOSTERIA</option>
 <option value= "456"> HOTEL</option>
 <option value= "HC"> HOTEL CANINO</option>
 <option value= "457"> HOTELERIA</option>
 <option value= "HTS"> HOTESISTA</option>
 <option value= "458"> HU</option>
 <option value= "459"> IGLESIA</option>
 <option value= "460"> ILUMINACION</option>
 <option value= "461"> IMP  EXP Y COMERCIAL DE FRUTAS</option>
 <option value= "EM2"> IMP. Y COM. DE EQUIPOS MARINOS</option>
 <option value= "IEM"> IMP. Y EXP. DE MAQUINAS</option>
 <option value= "462"> IMP. Y EXPORTADORA DE REPUESTOS</option>
 <option value= "IVL"> IMP.Y VENTAS DE LUBRICANTES</option>
 <option value= "IDR"> IMP.YDIST.DE REPUESTOS AUTOMOT</option>
 <option value= "IM3"> IMPECCIONES</option>
 <option value= "463"> IMPERMEABILIZACION</option>
 <option value= "464"> IMPLEMENTOS</option>
 <option value= "IDP"> IMPLEMENTOS DEPORTIVOS </option>
 <option value= "POT"> IMPORTACION</option>
 <option value= "IME"> IMPORTACION DE EQUIPOS MEDICOS</option>
 <option value= "IM1"> IMPORTACION DE MOTOS</option>
 <option value= "ICM"> IMPORTACION Y COMERCIALIZACION DE MAQ.</option>
 <option value= "465"> IMPORTACION Y DISTRYBUCION</option>
 <option value= "IVR"> IMPORTACION Y VENTA REPUESTO</option>
 <option value= "IYD"> IMPORTADO Y DISTRIBUIDOR</option>
 <option value= "466"> IMPORTADOR</option>
 <option value= "467"> IMPORTADOR Y EXPORTADOR</option>
 <option value= "IMP"> IMPORTADORA DE ARTICULOS DE REGALO</option>
 <option value= "IB2"> IMPORTADORA Y BAZAR</option>
 <option value= "468"> IMPORTADORA Y DIST</option>
 <option value= "469"> IMPORTADORA Y EXPORTADORA</option>
 <option value= "470"> IMPRENTA</option>
 <option value= "IMD"> IMPRESION DIGITAL</option>
 <option value= "471"> IMPRESION VALORES</option>
 <option value= "472"> IMPRESORES</option>
 <option value= "473"> IMPRESOS</option>
 <option value= "474"> IMPRESOS GRAFICOS</option>
 <option value= "ISM"> IND. SIDERURGICA Y METALURGICA</option>
 <option value= "I1M"> IND.Y COMERCIAL</option>
 <option value= "475"> INDUSTRIA</option>
 <option value= "INA"> INDUSTRIA ALIMENTOS</option>
 <option value= "476"> INDUSTRIA DE ALIMENTOS</option>
 <option value= "477"> INDUSTRIA DE FERTILIZANTES</option>
 <option value= "478"> INDUSTRIA DE FERTILIZANTES</option>
 <option value= "853"> INDUSTRIA DE PLASTICOS</option>
 <option value= "479"> INDUSTRIA ELABORADORA DE METAL</option>
 <option value= "IFP"> INDUSTRIA FRIGORIZADORA PRODUCTOS DEL MAR</option>
 <option value= "480"> INDUSTRIA MADERERA</option>
 <option value= "481"> INDUSTRIA MECANICA</option>
 <option value= "IMM"> INDUSTRIA METALMECANICA</option>
 <option value= "482"> INDUSTRIA METALURGICA</option>
 <option value= "483"> INDUSTRIA PANIFICADORA</option>
 <option value= "IP"> INDUSTRIA PESQUERA</option>
 <option value= "484"> INDUSTRIA TEXTIL</option>
 <option value= "485"> INDUSTRIAL</option>
 <option value= "486"> INDUSTRIAL Y COMERCIAL</option>
 <option value= "INF"> INFORMATICA</option>
 <option value= "487"> ING EN PROYECTOS INDUSTRIALES</option>
 <option value= "ITE"> INGEN. EN TELECOMUNICACIONES</option>
 <option value= "488"> INGENERIA Y MANTENCION</option>
 <option value= "489"> INGENIERIA</option>
 <option value= "IAB"> INGENIERIA AMBIENTA</option>
 <option value= "12V"> INGENIERIA CIVIL</option>
 <option value= "490"> INGENIERIA ELECTRICA</option>
 <option value= "IGS"> INGENIERIA EN SONIDO</option>
 <option value= "491"> INGENIERIA GEOTECNICA</option>
 <option value= "IGI"> INGENIERIA INDUSTRIAL</option>
 <option value= "492"> INGENIERIA MARITIMA </option>
 <option value= "493"> INGENIERIA Y CONSTRUCCION</option>
 <option value= "495"> INGENIERIA Y MONTAJE</option>
 <option value= "496"> INGENIERIA Y REPRESENTACIONES</option>
 <option value= "497"> INGENIERIA Y SERVICIO </option>
 <option value= "IIS"> INGENIERIA Y SERVICIOS</option>
 <option value= "ISI"> INGENIERIA Y SERVICIOS INDUSTRIALES</option>
 <option value= "498"> INGENIERO AGRONOMO</option>
 <option value= "499"> INGENIERO MECANICO</option>
 <option value= "500"> INGENIEROS COMERCIALES</option>
 <option value= "501"> INMOBILIARIA</option>
 <option value= "IIN"> INMOBILIARIA E INVERSIONES </option>
 <option value= "IM9"> INMOBILIARIA Y CONSTRUCTORA</option>
 <option value= "I01"> INMOBILIARIA Y OTROS</option>
 <option value= "502"> INMOVILIARIA</option>
 <option value= "503"> INMUEBLES</option>
 <option value= "ITC"> INNOVACIONES TECNOLOGICAS</option>
 <option value= "ITO"> INSPECCION TECNICA DE OBRA</option>
 <option value= "504"> INST.ELECTRICAS</option>
 <option value= "505"> INSTALACION DE CARPAS</option>
 <option value= "IQM"> INSTALACION DE EQUIPOS MEDICOS</option>
 <option value= "506"> INSTALACIONES</option>
 <option value= "517"> INSTALACIONES</option>
 <option value= "ISS"> INSTALACIONES DE SISTEMAS DE SEGURIDAD</option>
 <option value= "I1"> INSTALACIONES ELECTRICA INDUSTRIALES</option>
 <option value= "507"> INSTALACIONES ELECTRICAS</option>
 <option value= "518"> INSTALACIONES ELECTRICAS</option>
 <option value= "I2"> INSTALACIONES HIDRAULICAS</option>
 <option value= "508"> INSTALACIONES INDUSTRIALES</option>
 <option value= "509"> INSTALACIONES SANITARIAS</option>
 <option value= "ITT"> INSTALACIONES TERMICAS</option>
 <option value= "510"> INSTALADOR</option>
 <option value= "511"> INSTITUC. DE ASISTENCIA SOCIAL</option>
 <option value= "IFE"> INSTITUCION FINANCIERA</option>
 <option value= "512"> INSTITUCION PUBLICA</option>
 <option value= "12P"> INSTITUCION RELIGIOSA</option>
 <option value= "845"> INSTITUTO</option>
 <option value= "513"> INSTRUMENTOS MUSICALES</option>
 <option value= "INS"> INSUMOS</option>
 <option value= "514"> INSUMOS AGRICOLAS</option>
 <option value= "515"> INSUMOS DE COMPUTACION</option>
 <option value= "IJY"> INSUMOS DE JOYERIAS</option>
 <option value= "IM2"> INSUMOS MEDICO Y DENTALES</option>
 <option value= "516"> INSUMOS MINEROS</option>
 <option value= "ITX"> INSUMOS TEXTILES</option>
 <option value= "SPL"> INSUMOS Y VENTAS DE MATERIALES</option>
 <option value= "519"> INTITUCION DE ASISTENCIA SOCIAL</option>
 <option value= "520"> INVERNADERO</option>
 <option value= "01I"> INVERNADEROS</option>
 <option value= "521"> INVERSIONES</option>
 <option value= "522"> INVESTIGACION</option>
 <option value= "523"> JARDIN INFANTIL</option>
 <option value= "524"> JARDINERIA</option>
 <option value= "525"> JARDINERIA Y PAISAJISMO</option>
 <option value= "JJJ"> JARDINES</option>
 <option value= "526"> JARDINES Y CONSTRUCION</option>
 <option value= "527"> JOYERIA</option>
 <option value= "528"> JUEGOS ELECTRONICOS</option>
 <option value= "529"> JUEGOS INFANTILES</option>
 <option value= "JGT"> JUGUETERIA</option>
 <option value= "530"> JUGUETES</option>
 <option value= "531"> JUNTA DE VECINOS</option>
 <option value= "k3"> kiosco</option>
 <option value= "1"> KIOSKO</option>
 <option value= "532"> LABORATORIO</option>
 <option value= "C,."> LACTEOS</option>
 <option value= "LAM"> LAMINAS </option>
 <option value= "533"> LAMPARAS</option>
 <option value= "LVA"> LAVADO DE AUTO</option>
 <option value= "11"> LAVANDERIA</option>
 <option value= "534"> LAVANDERIA INDUSTRIAL</option>
 <option value= "535"> LAVASECO</option>
 <option value= "-.-"> LECHERIA</option>
 <option value= "536"> LETREROS</option>
 <option value= "LPB"> LETREROS PUBLICITARIOS</option>
 <option value= "537"> LIBRERIA</option>
 <option value= "LIN"> LIMPIEZA INDUSTRIAL</option>
 <option value= "LGC"> LOGISTICA</option>
 <option value= "538"> LUBRICENTRO</option>
 <option value= "MI"> MACANICA</option>
 <option value= "539"> MADERAS</option>
 <option value= "540"> MADERAS Y METAL</option>
 <option value= "541"> MAESTRANZA</option>
 <option value= ".V-"> MAESTRANZA Y CONSTRUCCION</option>
 <option value= "M2F"> MAESTRANZA Y FERRETERIA</option>
 <option value= "543"> MANIPULACION DE LA CARGA </option>
 <option value= "544"> MANOFACTURA ARTICULOS PLASTICOS</option>
 <option value= "ART"> MANTANCIO</option>
 <option value= "545"> MANTENCION</option>
 <option value= "542"> MANTENCION INDUSTRIAL</option>
 <option value= "MAT"> MANTENCION INDUSTRIAL</option>
 <option value= "MMI"> MANTENCION Y MONTAJE INDUSTRIAL</option>
 <option value= "MTO"> MANTENEMIENTO</option>
 <option value= "MAN"> MANTENIMIENTO</option>
 <option value= "MIT"> MANTENIMIENTO INTEGRAL</option>
 <option value= "546"> MANUALIDADES</option>
 <option value= "547"> MANUFACTURA</option>
 <option value= "548"> MANUFACTURA EN MADERA Y METAL</option>
 <option value= "549"> MAQ. DE COSER INDUSTRIALES</option>
 <option value= "550"> MAQUINA ALGODONERA </option>
 <option value= "551"> MAQUINARIA</option>
 <option value= "552"> MAQUINARIAS</option>
 <option value= "MDC"> MAQUINAS DE COSER</option>
 <option value= "MQE"> MAQUINAS EXPENDEDORAS</option>
 <option value= "553"> MARCOS</option>
 <option value= "554"> MARMOL</option>
 <option value= "555"> MARMOL Y MUEBLES</option>
 <option value= "556"> MARMOLERIA</option>
 <option value= "MAR"> MARROQUINERIA</option>
 <option value= "557"> MARTILLERO PUBLICO</option>
 <option value= "558"> MASCOTAS</option>
 <option value= "559"> MATADERO</option>
 <option value= "MEP"> MATALES Y POLIMEROS</option>
 <option value= "560"> MATANZA DE GANADO</option>
 <option value= "561"> MATERIALES DE CONSTRUCCION</option>
 <option value= "562"> MATERIALES ELECTRICOS</option>
 <option value= "MFE"> MATERIALES FERRETERIA </option>
 <option value= "MTC"> MATRICERIA</option>
 <option value= "MTR"> MATRICERIA Y MECANICA</option>
 <option value= "999"> MATRICERO</option>
 <option value= "MMM"> MATRICES</option>
 <option value= "563"> MAYORISTA  MAQUINARIA  MOTORES</option>
 <option value= "564"> MAYORISTA ARTICULOS FERRETERIA </option>
 <option value= "565"> MAYORISTA DETERGENTE</option>
 <option value= "MM1"> MAYORISTA MAQUINARIAS</option>
 <option value= "566"> MECANICA</option>
 <option value= "MDP"> MECANICA DE PRESICION</option>
 <option value= "MCH"> MECANICA HIDRAULICA</option>
 <option value= "MEI"> MECANICA INDUSTRIAL</option>
 <option value= "567"> MECANIZADO</option>
 <option value= "568"> MEDICINA</option>
 <option value= "MVT"> MEDICO VETERINARIO</option>
 <option value= "569"> MENAJE</option>
 <option value= "570"> MENESTRA</option>
 <option value= "MSJ"> MENSAJERIA</option>
 <option value= "571"> MERCADO</option>
 <option value= "572"> MERCERIA</option>
 <option value= "573"> METAL MECANICA</option>
 <option value= "MYP"> METALES Y PLASTICOS</option>
 <option value= "574"> METALMECANICA</option>
 <option value= "575"> METALMECANICA METALURGIA</option>
 <option value= "576"> METALURGICA</option>
 <option value= "577"> MILTITIENDA</option>
 <option value= "578"> MINERALES</option>
 <option value= "579"> MINERIA</option>
 <option value= "580"> MINERIA  AGRICOLA Y CONSTRUCCI</option>
 <option value= "581"> MINI MARKERT</option>
 <option value= "MIM"> MINI MERCADO</option>
 <option value= "582"> MINICENTRO</option>
 <option value= "583"> MINIMARKET</option>
 <option value= "848"> MISION DIPLOMATICA</option>
 <option value= "584"> MOBILIARIO</option>
 <option value= "585"> MOLIENDA</option>
 <option value= "586"> MOLINO</option>
 <option value= "587"> MOLINO DE TRIGO</option>
 <option value= "588"> MONTAJE</option>
 <option value= "589"> MONTAJE IND</option>
 <option value= "590"> MONTAJE INDUSTRIAL</option>
 <option value= "591"> MONTAJES</option>
 <option value= "AE2"> MONTAJES ELECT., ASESORIAS Y CONT.</option>
 <option value= "ES"> MONTAJES INDUSTRIALES</option>
 <option value= "592"> MOTEL</option>
 <option value= "MR"> MOTORES  Y REPUESTOS</option>
 <option value= "593"> MOTORES ELECTRICOS</option>
 <option value= "594"> MOTORES Y BOMBAS</option>
 <option value= "MOT"> MOVIMIENTO DE TIERRA</option>
 <option value= "MDT"> MOVIMIENTO DE TIERRAS</option>
 <option value= "595"> MOVIMIENTOS DE TIERRA</option>
 <option value= "596"> MUEBLERIA</option>
 <option value= "MC"> MUEBLERIA Y CONSTRUCCION</option>
 <option value= "MUE"> MUEBLES</option>
 <option value= "598"> MUEBLES DE OFICINA</option>
 <option value= "MBD"> MUEBLES Y DECORACION</option>
 <option value= "599"> MUEBLES Y EQUIPOS DE OFICINA</option>
 <option value= "K2"> MULTI MARKET</option>
 <option value= "600"> MUNICIPALIDAD</option>
 <option value= "601"> MUNICIPALIDAD PARQUE INTERCOMU</option>
 <option value= "602"> MUSEO</option>
 <option value= "597"> MUSICA</option>
 <option value= "603"> NAVIERA</option>
 <option value= "604"> NEUMATICOS</option>
 <option value= "605"> NOTARIA</option>
 <option value= "NA"> NUTRICION ANIMALES</option>
 <option value= "ONG"> O.N.G</option>
 <option value= "XX."> OBRA MENORES</option>
 <option value= "OB"> OBRAS</option>
 <option value= "OAB"> OBRAS AMBIENTALES</option>
 <option value= "606"> OBRAS CIVILES</option>
 <option value= "607"> OBRAS DE INGENIERIA</option>
 <option value= "ODI"> OBRAS DE INGIERIA</option>
 <option value= "OIM"> OBRAS IG. MECANICAS</option>
 <option value= "OOO"> OBRAS INGENIERIA</option>
 <option value= "608"> OBRAS MENORES</option>
 <option value= "609"> OBRAS PUBLICAS</option>
 <option value= "OSA"> OBRAS SANITARIAS</option>
 <option value= "OBL"> OBRAS VIALES</option>
 <option value= "610"> OBRAS Y MONTAJES</option>
 <option value= "O8"> OBRES DE INGENIERIA Y CONSTRUCCION </option>
 <option value= "OL"> OCEANOGRAFIA Y LABORATORIO</option>
 <option value= "PSU"> OPERACIONES SUBMARINAS</option>
 <option value= "611"> OPTICA</option>
 <option value= "612"> ORFEBRE</option>
 <option value= "OCM"> ORGANISMOS COMUNITARIOS</option>
 <option value= "613"> ORGANIZACION RELIGIOSAS</option>
 <option value= "614"> ORGN  RELIGIOSAS</option>
 <option value= "850"> ORNITOLOGOS</option>
 <option value= "OTT"> ORTESISTA</option>
 <option value= "615"> ORTOPEDIA</option>
 <option value= "OAC"> OTRAS ACTIVIDADES</option>
 <option value= "OEC"> OTRAS ACTIVIDADES EMP.</option>
 <option value= "OAE"> OTRAS ACTIVIDADES EMPRESARIALES</option>
 <option value= "616"> otras asociaciones</option>
 <option value= "617"> OTROS PROFESIONALES </option>
 <option value= "OPS"> OTROS PROFESIONALES DE LA SALUD </option>
 <option value= "OTS"> OTROS SERVICIOS</option>
 <option value= "618"> OTROS SERVICIOS DE INGENIERIA</option>
 <option value= "OSP"> OTROS SERVIOS PROF.</option>
 <option value= "619"> PAISAJISMO</option>
 <option value= "620"> PAJARERIA</option>
 <option value= "621"> PANADERIA</option>
 <option value= "PYP"> PANADERIA Y PASTELERIA</option>
 <option value= "PMA"> PANELES DE MADERA</option>
 <option value= "PAN"> PANIFICADORA</option>
 <option value= "622"> PANTALLAS</option>
 <option value= "623"> PAPELES</option>
 <option value= "624"> PAQUETERIA</option>
 <option value= "PRB"> PARABRISAS</option>
 <option value= "625"> PARCELACION</option>
 <option value= "626"> PARROQUIA</option>
 <option value= "627"> PASTELERIA</option>
 <option value= "PTA"> PASTELERIA.</option>
 <option value= "628"> PAV.Y AMP.DE VIVIENDA</option>
 <option value= "PVM"> PAVIMENTOS</option>
 <option value= "PLC"> PELUCAS</option>
 <option value= "629"> PELUQUERIA</option>
 <option value= "630"> PERFORACIONES</option>
 <option value= "631"> PERFUMERIA</option>
 <option value= "pp1"> periodico</option>
 <option value= "632"> PERIODISTICO</option>
 <option value= "PI"> PERNERIA</option>
 <option value= "633"> PERNO Y FERRETERIA</option>
 <option value= "900"> PERSONA NATURAL</option>
 <option value= "PED"> PES</option>
 <option value= "634"> PESCA</option>
 <option value= "PDC"> PESCADERIA</option>
 <option value= "635"> PESQUERA</option>
 <option value= "PYM"> PETREOS Y MARMOL</option>
 <option value= "PIA"> PIANOS</option>
 <option value= "PIG"> PIGNIC</option>
 <option value= "PID"> PINTADO INDUSTRIAL</option>
 <option value= "636"> PINTURA</option>
 <option value= "PIN"> PINTURAS</option>
 <option value= "PII"> PINTURAS INDUSTRIALES</option>
 <option value= "PIS"> PISCICULTURA</option>
 <option value= "637"> PISCINAS</option>
 <option value= "638"> PISICULTURA</option>
 <option value= "PDM"> PISOS DE MADERA</option>
 <option value= "639"> PIZZAS</option>
 <option value= "640"> PIZZERIA</option>
 <option value= "386"> PLANTA FAENADORA</option>
 <option value= "PLL"> PLANTA LECHERA</option>
 <option value= "641"> PLANTAS MEDICINALES</option>
 <option value= "642"> PLANTAS Y FLORES </option>
 <option value= "643"> PLANTAS Y JARDIN</option>
 <option value= "644"> PLASTICO</option>
 <option value= "645"> PLASTICOS</option>
 <option value= "646"> PODA Y TALA</option>
 <option value= "PZ"> POLARIZADO</option>
 <option value= "647"> POLLOS ASADOS</option>
 <option value= "P23"> PORTONES AUTOMATICOS</option>
 <option value= "PZP"> POZOS PROFUNDOS</option>
 <option value= "648"> PREFABRICADOS HORMIGON</option>
 <option value= "PVR"> PRENDAS DE VESTIR</option>
 <option value= "649"> PREPARADOR</option>
 <option value= "650"> PREPENZA DIGITAL</option>
 <option value= "651"> PRESTACION DE SERVICIO</option>
 <option value= "PCI"> PRESTACION DE SERVICIOS</option>
 <option value= "PRM"> PRESTACIONES MEDICAS</option>
 <option value= "652"> PREVENCION DE RIESGO</option>
 <option value= "PRE"> PREVISION</option>
 <option value= "653"> PROCESADORA</option>
 <option value= ".N-"> PROCESADORA DE ALIMENTOS</option>
 <option value= "654"> PROCESAMIENTO Y COM. ACEROS</option>
 <option value= "655"> PROD. HUMUS Y COMPOST.</option>
 <option value= "POM"> PROD. IND. OBTENIDOS DE ORG. MARINOS</option>
 <option value= "PEV"> PROD. Y ELAB. DE VINOS </option>
 <option value= "PSF"> PROD. Y SERV. PARA LA FUNDICION</option>
 <option value= "841"> Prod., com.,dist,  imprt y concentrados</option>
 <option value= "852"> PRODUC DE UVA Y ELAB VINOS</option>
 <option value= "PVC"> PRODUCCCION EN VIVEROS</option>
 <option value= ",L."> PRODUCCION</option>
 <option value= "PAV"> PRODUCCION AUDIOVISUAL</option>
 <option value= "VIV"> PRODUCCION EN VIVERO O CULTIVO FRUTAL</option>
 <option value= "POC"> PRODUCCION HUEVO DE CAMPO</option>
 <option value= "PMS"> PRODUCCION MUSICAL</option>
 <option value= "657"> PRODUCCION Y COM DE PLANTAS</option>
 <option value= "658"> PRODUCCION Y DIST DE AGUAS</option>
 <option value= "843"> PRODUCCION Y DIST. DE PRODUCTOS AGROINDUSTRIALES</option>
 <option value= "851"> Produccion y venta de carbon y briquetas</option>
 <option value= "659"> PRODUCCIONES</option>
 <option value= "656"> PRODUCCIONES ARTISTICAS</option>
 <option value= "PDE"> PRODUCCIONES DE EVENTOS</option>
 <option value= ",N-"> PRODUCTOR</option>
 <option value= "660"> PRODUCTOR Y ELABORADOR DE VINOS</option>
 <option value= "661"> PRODUCTORA</option>
 <option value= "PRO"> PRODUCTORA DE ALGAS</option>
 <option value= "662"> PRODUCTORA DE CINE </option>
 <option value= "663"> PRODUCTORA DE SEMILLAS</option>
 <option value= "P12"> PRODUCTOS ALIMENTICIOS</option>
 <option value= "PCF"> PRODUCTOS COMERCIAL DE FRUTAS</option>
 <option value= "664"> PRODUCTOS CONGELADOS DEL MAR</option>
 <option value= "665"> PRODUCTOS DE PLASTICOS</option>
 <option value= "PDP"> PRODUCTOS DE POLIETILENO</option>
 <option value= "PSO"> PRODUCTOS DE SOLDAR</option>
 <option value= "666"> PRODUCTOS LACTEOS</option>
 <option value= "667"> PRODUCTOS METALICOS </option>
 <option value= "PNA"> PRODUCTOS NATURALES</option>
 <option value= "PR5"> PRODUCTOS PARA LA MINERIA</option>
 <option value= "A.."> PRODUCTOS PARA MASCOTAS</option>
 <option value= "668"> PRODUCTOS QUIMICOS</option>
 <option value= "PSM"> PRODUCTOS Y SERVICIOS  MINERIA</option>
 <option value= "669"> PROMOCIONES</option>
 <option value= "670"> PROPIEDADES</option>
 <option value= "PIR"> PROSPECCIONES </option>
 <option value= "PAE"> PROTECTORA DE ANIMALES EN VIAS DE EXT.</option>
 <option value= "PDN"> PROVEDOR DE NAVES</option>
 <option value= "P1"> PROVEEDOR</option>
 <option value= "671"> PROVEEDOR IND</option>
 <option value= "672"> PROVEEDOR MARITIMO</option>
 <option value= "673"> PROVEEDOR PARA LA SALUD</option>
 <option value= "674"> PROVEEDORES MARITIMOS</option>
 <option value= "675"> PROVISIONES</option>
 <option value= "676"> PROYECTO P02-051-F ICM</option>
 <option value= "677"> PROYECTOS</option>
 <option value= "PAM"> PROYECTOS AMBIENTALES </option>
 <option value= "PYE"> PROYECTOS DE ENERGIA</option>
 <option value= "PDI"> PROYECTOS DE INGENIERIA</option>
 <option value= "PEI"> PROYECTOS E INSTALACIONES</option>
 <option value= "PRI"> PROYECTOS INDUSTRIALES</option>
 <option value= "PIB"> PROYECTOS INMOBILIARIOS </option>
 <option value= "PDS"> PRUDUCCION DE SEMILLAS</option>
 <option value= "678"> PSIQUIATRIA</option>
 <option value= "679"> PUB</option>
 <option value= "680"> PUBLICIDAD</option>
 <option value= "A00"> PUBLICIDAD OBRAS MENORES</option>
 <option value= "PYK"> PUBLICIDAD Y MARKETING</option>
 <option value= "681"> PURIFICADORES DE AGUA</option>
 <option value= "682"> QUIMICOS</option>
 <option value= "QQQ"> QUINCALLERIA</option>
 <option value= "683"> RADIADORES</option>
 <option value= "RA1"> RADIODIFUCION</option>
 <option value= "VVV"> RAPARACION</option>
 <option value= "684"> RECAUCHAJES</option>
 <option value= "685"> RECICLAJE</option>
 <option value= "Z.-"> RECICLAMIENTO</option>
 <option value= "686"> RECREACION</option>
 <option value= "687"> RECTIFICACION DE MOTORES</option>
 <option value= "RR3"> RECTIFICADORA </option>
 <option value= "688"> RECUBRIMIENTO</option>
 <option value= "689"> RECUPERACION DE METALES</option>
 <option value= "RSP"> RECUPERACION DE SUS PRODUCTOS </option>
 <option value= "RDM"> RECUPERADORA DE METALES</option>
 <option value= "690"> RECUPERADORA DE PAPEL</option>
 <option value= "691"> RECUPERADORA DE PAPEL</option>
 <option value= "RSN"> RECURSOS NATURALES </option>
 <option value= "692"> REFINERIA</option>
 <option value= "RR1"> REFORESTACION</option>
 <option value= "693"> REFRIGERACION</option>
 <option value= "694"> REFRIGERACION INDUSTRIAL</option>
 <option value= "R1"> REFRIGERACION Y OTROS</option>
 <option value= "695"> REHABILITACION</option>
 <option value= "RL"> RELIGIOSO</option>
 <option value= "RCL"> RELOJES CONTROL</option>
 <option value= "REM"> REMATES</option>
 <option value= "696"> REMODELACIONES</option>
 <option value= "697"> RENTISTA</option>
 <option value= "REN"> RENTISTA INMUEBLES</option>
 <option value= "698"> REP Y ACCESORIOS PARA LA INDUS</option>
 <option value= "RSC"> REP. DE SIST. DE CONTROL DE PROC. IND.</option>
 <option value= "RDP"> REP. Y CRIANZA DE PECES</option>
 <option value= "RAI"> REP.DE AIRE ACONDICIONADO</option>
 <option value= "699"> REPARACIN Y MANTENCION ACERO INOX Y OTROS</option>
 <option value= "700"> REPARACION</option>
 <option value= "RRR"> REPARACION DE EQUIPOS MEDICOS</option>
 <option value= "RMH"> REPARACION DE MAQUINAS Y HERRAMIENTAS</option>
 <option value= "RPF"> REPARACION Y FABRICACION</option>
 <option value= "RYM"> REPARACION Y MANTENCION</option>
 <option value= "RPI"> REPARACION Y MANTENCION DE MAQUINARIA</option>
 <option value= "<,."> REPARACION Y VENTA </option>
 <option value= "701"> REPARACIONES</option>
 <option value= "702"> REPARACIONES ELECTRICAS</option>
 <option value= "703"> REPARACIONES MAQUINARIAS</option>
 <option value= "S"> REPARACIONES MARITIMAS</option>
 <option value= "704"> REPARACIONES Y MONTAJE SE</option>
 <option value= "705"> REPARADORA DE CALZADO</option>
 <option value= "C.M"> REPORTERIA</option>
 <option value= "706"> REPRESENTACIONES</option>
 <option value= "OT"> representaciones</option>
 <option value= "RFE"> REPRESENTANTE DE FIRMAS EXTRANJERAS</option>
 <option value= "707"> REPROD. DE PECES Y MARISCOS</option>
 <option value= "RBC"> REPUESTO DE BICICLETAS</option>
 <option value= "708"> REPUESTOS</option>
 <option value= "RIN"> REPUESTOS INDUSTRIALES</option>
 <option value= "709"> REPUESTOS NAUTICOS</option>
 <option value= "REP"> REPUJADOS</option>
 <option value= "847"> RESCATE DE PRIMATES</option>
 <option value= "710"> RESIDENCIAL</option>
 <option value= "711"> RESIDUOS SOLIDOS</option>
 <option value= "RBP"> RESTAURACION DE BIENES PATRIMONIALES</option>
 <option value= "RMB"> RESTAURACION DE MUEBLES</option>
 <option value= "712"> RESTAURANT</option>
 <option value= "713"> RESTORAN EXPOSICIIONES Y ARTESANIA</option>
 <option value= "RET"> RESTORANT</option>
 <option value= "RR2"> RETIFICADORA </option>
 <option value= "Rev"> REVESTIMIENTO</option>
 <option value= "RYP"> REVESTIMIENTOS Y PINTURAS IND</option>
 <option value= "XX7"> REVISION TECNICA</option>
 <option value= "714"> RIEGO</option>
 <option value= "715"> ROPA DE VESTIR</option>
 <option value= "R02"> ROTISERIA</option>
 <option value= "REC"> RRR</option>
 <option value= "716"> SALACUNA</option>
 <option value= "717"> SALMONERA</option>
 <option value= "SDB"> SALON DE BAILE</option>
 <option value= "718"> SALON DE BELLEZA </option>
 <option value= "719"> SALON DE TE</option>
 <option value= "720"> SALUD</option>
 <option value= "SAN"> SANDUICHERIA</option>
 <option value= "A23"> SANEAMIENTO AMBIENTAL </option>
 <option value= "STS"> SANITARIOS</option>
 <option value= "721"> SANITARIOS QUIMICOS</option>
 <option value= "SA3"> SASTRERIA</option>
 <option value= "722"> SAUNAS</option>
 <option value= "723"> SCHOPERIA</option>
 <option value= "724"> SECADO DE ALGAS</option>
 <option value= "725"> SECADO DE MADERA</option>
 <option value= "726"> SEGURIDAD</option>
 <option value= "2"> SEGURIDAD INDUSTRIAL</option>
 <option value= "727"> SEGURIDAD Y  CONSTRUCCION</option>
 <option value= "SEE"> SEGURIDAD Y EVENTOS </option>
 <option value= "728"> SEGUROS</option>
 <option value= "SIL"> SEMILLAS</option>
 <option value= "729"> SENALIZACION</option>
 <option value= "730"> SERV,AGRICOLA</option>
 <option value= "SCE"> SERV. DE COMP. DE EMISIONES</option>
 <option value= "SRH"> SERV. DE RECURSOS HUMANOS</option>
 <option value= "SPP"> SERV. INT. PARA LA PROD.DE EVENTOS</option>
 <option value= "SC1"> SERV. PREST.POR CONC. DE CARRETERA</option>
 <option value= "753"> SERV. RELAC. CON LA ACUICULTURA</option>
 <option value= "731"> SERV. TEC.</option>
 <option value= "SYC"> SERV. Y COMERC. DE PAPELES</option>
 <option value= "SAL"> SERV.DE ARAMADO DE LUMINARIAS</option>
 <option value= "732"> SERV.PORTUARIOS</option>
 <option value= "SMI"> SERVI</option>
 <option value= "733"> SERVICENTRO</option>
 <option value= "SAC"> SERVICIO A CONTENEDORES</option>
 <option value= "SAI"> SERVICIO A LA MINERIA</option>
 <option value= "SAU"> SERVICIO AUTOMOTRIZ</option>
 <option value= "01C"> SERVICIO COMIDAS</option>
 <option value= "SC"> SERVICIO DE COMUNICACIONES</option>
 <option value= "SED"> SERVICIO DE DESABOLLADURA</option>
 <option value= "SDF"> SERVICIO DE FABRICACION</option>
 <option value= "SLT"> SERVICIO DE LAVADOS DE TAPICES</option>
 <option value= "SPE"> SERVICIO DE PACKING EXPORTACION PROD. AGRICOLA</option>
 <option value= "SDP"> SERVICIO DE PINTURA</option>
 <option value= "SDR"> SERVICIO DE REPARACION</option>
 <option value= "SVC"> SERVICIO DE TROQUELADO</option>
 <option value= "SFF"> SERVICIO FORESTAL</option>
 <option value= "735"> SERVICIO MARITIMO</option>
 <option value= "SMM"> SERVICIO METAL MECANICA</option>
 <option value= "SMT"> SERVICIO METALURGICA</option>
 <option value= "SPT"> SERVICIO PRODUCTOS TECNICOS</option>
 <option value= "736"> SERVICIO PUBLICO</option>
 <option value= "737"> SERVICIO SOCIAL</option>
 <option value= "738"> SERVICIO TECNICO</option>
 <option value= "739"> SERVICIO UTILIDAD PUBLICA</option>
 <option value= "SYM"> SERVICIO Y MANTENCION</option>
 <option value= "SYP"> SERVICIO Y PRODUCCION</option>
 <option value= "740"> SERVICIOS</option>
 <option value= "SAM"> SERVICIOS A LA MINERIA</option>
 <option value= "SAG"> SERVICIOS AGRICOAS</option>
 <option value= "SAA"> SERVICIOS AGRICOLAS</option>
 <option value= "SCC"> SERVICIOS AMBIENTALES Y CONST.</option>
 <option value= "SVA"> SERVICIOS AUTOMOTRICES</option>
 <option value= "SCO"> SERVICIOS COMERCIALES</option>
 <option value= "SEC"> SERVICIOS COMPUTACIONALES</option>
 <option value= "SLI"> SERVICIOS DE ALIMENTACION</option>
 <option value= "741"> SERVICIOS DE AMPLIFICACION</option>
 <option value= "SDA"> SERVICIOS DE ARQUITECTURA</option>
 <option value= "SAR"> SERVICIOS DE ARRIENDO</option>
 <option value= "742"> SERVICIOS DE BUFFETS</option>
 <option value= "743"> SERVICIOS DE CONSTRUCCION CIVIL</option>
 <option value= "V.-"> SERVICIOS DE FRIO</option>
 <option value= "744"> SERVICIOS DE INGENIERIA</option>
 <option value= "SEM"> SERVICIOS DE MANTENCION</option>
 <option value= "2.,"> SERVICIOS DE TURISMO</option>
 <option value= "745"> SERVICIOS ELECTRICO</option>
 <option value= "SEL"> SERVICIOS ELECTRICOS </option>
 <option value= "CSE"> SERVICIOS EN CONSTRUCCION Y ELE</option>
 <option value= "CES"> SERVICIOS EN COSTRUCCION</option>
 <option value= "SFR"> SERVICIOS FERESTALES</option>
 <option value= "SFL"> SERVICIOS FORESTALES </option>
 <option value= "SRG"> SERVICIOS GENERALES</option>
 <option value= "746"> SERVICIOS GEOLOGICOS Y PROSPECCION</option>
 <option value= "SG"> SERVICIOS GRAFICOS</option>
 <option value= "SEH"> SERVICIOS HIDRAULICOS</option>
 <option value= "747"> SERVICIOS INDUSTRIALES</option>
 <option value= "748"> SERVICIOS INMOBILIARIO</option>
 <option value= "SER"> SERVICIOS INTEGRALES</option>
 <option value= "SCN"> SERVICIOS MECANICOS</option>
 <option value= "SME"> SERVICIOS MEDICOS</option>
 <option value= "SMC"> SERVICIOS MINERIA Y CONSTRUCCION</option>
 <option value= "SIN"> SERVICIOS NINTEGRALES</option>
 <option value= "734"> SERVICIOS ODONTOLOGICO</option>
 <option value= "750"> SERVICIOS PARA LA MINERIA</option>
 <option value= "751"> SERVICIOS PUBLICIDAD</option>
 <option value= "752"> SERVICIOS PUBLICITARIO</option>
 <option value= "754"> SERVICIOS SANITARIOS</option>
 <option value= "SS"> SERVICIOS SOCIALES</option>
 <option value= "SYE"> SERVICIOS Y EQUIPOS</option>
 <option value= "749"> SERVICIOS Y MANTENCION INDUSTRIAL</option>
 <option value= "S05"> SERVICIOS Y MONTAJE INDUSTRIAL</option>
 <option value= "SYT"> SERVICIOS Y TRANSPORTES</option>
 <option value= "SDI"> SERVISIOD DIESEL</option>
 <option value= "0A1"> SEVICIOS AUTOMOTRICES</option>
 <option value= "SC2"> SEVICIOS Y CONSTRUCCION</option>
 <option value= "755"> SINDICATO</option>
 <option value= "756"> SISTEMAS ACUSTICOS</option>
 <option value= "757"> SISTEMAS DE SEGURIDAD</option>
 <option value= "758"> SISTEMAS IDRAULICOS</option>
 <option value= "759"> SOC DE INVERSIONES FCA ALIMENT</option>
 <option value= "760"> SOCIAL</option>
 <option value= "761"> SOLDAD</option>
 <option value= "SLD"> SOLDADOR</option>
 <option value= "762"> SOLDADURA</option>
 <option value= "763"> SONDAJES</option>
 <option value= "764"> SONDAJES MINEROS</option>
 <option value= "X1"> SONIDOS</option>
 <option value= "SF1"> SRVICIOS FORESTALES</option>
 <option value= "SYA"> SRVICIOS Y ASESORIAS</option>
 <option value= "SI1"> SRVICIOSDE IMPRESION Y PUBLICIDAD</option>
 <option value= "765"> SUBCONTRATISTA</option>
 <option value= "766"> SUELERIA</option>
 <option value= "767"> SUMINISTROS INDUSTRIALES</option>
 <option value= "768"> SUPERMERCADO</option>
 <option value= "..0"> T V CABLE</option>
 <option value= "*78"> TABAQUERIA</option>
 <option value= "769"> TALLER</option>
 <option value= "TAR"> TALLER ARTISTICO</option>
 <option value= "771"> TALLER DE MODELOS</option>
 <option value= "770"> TALLER DE SERIGRAFIA</option>
 <option value= "TSY"> TALLER DE SOLDADURA Y OTROS</option>
 <option value= "TEM"> TALLER ESTAMPADOS METALICOS</option>
 <option value= "772"> TALLER MECANICO</option>
 <option value= "773"> TALLER METALICO</option>
 <option value= "774"> TAPICERIA</option>
 <option value= "TE"> TE</option>
 <option value= "TEA"> TEATRO</option>
 <option value= "775"> TECNICO MECANICO</option>
 <option value= "776"> TECNOLOGIA</option>
 <option value= "TEC"> TECNOLOGIA AGRICOLA</option>
 <option value= "777"> TEJIDO</option>
 <option value= "T01"> TELAS</option>
 <option value= "TE1"> TELECOMUNICACCIONES</option>
 <option value= "778"> TELECOMUNICACIONES</option>
 <option value= "779"> TELEFONIA</option>
 <option value= "780"> TELEFONIA Y ELECTRICIDAD</option>
 <option value= "781"> TELEVISION</option>
 <option value= "782"> TEXTIL</option>
 <option value= "TI1"> TIENDAS</option>
 <option value= "783"> TINTORERIA</option>
 <option value= "TPF"> TOPOGRAFIA</option>
 <option value= "784"> TORNERIA</option>
 <option value= "785"> TORNERIA  MECANICA</option>
 <option value= "786"> TORNO MECANICO</option>
 <option value= "tos"> tostado y confitado</option>
 <option value= "787"> TOSTADURIA</option>
 <option value= "TS2"> TRABAJO SUBMARINO</option>
 <option value= "TRY"> TRAMOYISTA</option>
 <option value= "TTR"> TRANSFORMACION TODO TIPO DE RESIDUOS</option>
 <option value= "788"> TRANSFORMACIONES</option>
 <option value= "789"> TRANSFORMADORES</option>
 <option value= "TRE"> TRANSMICION ELECTRICA</option>
 <option value= "790"> TRANSP. DE CARGA POR FERROCARRIL ES</option>
 <option value= "791"> TRANSP., DISTRIB. Y SUMINISTRO</option>
 <option value= "792"> TRANSPORTADORAS</option>
 <option value= "793"> TRANSPORTE</option>
 <option value= "794"> TRANSPORTE AEREO</option>
 <option value= "T1"> TRANSPORTE CARGA POR CARRETERA</option>
 <option value= "795"> TRANSPORTE DE PASAJEROS</option>
 <option value= "TDR"> TRANSPORTE DE RESIDUOS</option>
 <option value= "796"> TRANSPORTE DE VALIJA</option>
 <option value= "TRV"> TRANSPORTE DE VALORES</option>
 <option value= "TRM"> TRANSPORTE MARITIMO</option>
 <option value= "TAM"> TRANSPORTE Y ARRIENDO MAQ.</option>
 <option value= "TAS"> TRANSPORTE Y ASERRADERO</option>
 <option value= "MYM"> TRANSPORTE Y MANTENCION</option>
 <option value= "797"> TRANSPORTES</option>
 <option value= "TDC"> TRANSPORTES DE CARGA </option>
 <option value= "TCA"> TRANSPORTES DE CARGO Y ARIDOS</option>
 <option value= "798"> TRANSPORTES DE COMBUSTIBLES</option>
 <option value= "799"> TRANSPORTES OCEANICOS</option>
 <option value= "TYA"> TRANSPORTES Y AGRICOLA</option>
 <option value= "TYS"> TRANSPORTES Y SERVICIOS</option>
 <option value= "TTT"> TRANSPORTISTA</option>
 <option value= "TMO"> TRAT. DE METALES OBRAS ING. MEC.</option>
 <option value= "800"> TRATAMIENTO BASURA</option>
 <option value= "801"> TRATAMIENTO DE AGUAS</option>
 <option value= "TRA"> TRATAMIENTO DE MET. Y REVEST.</option>
 <option value= "802"> TRATAMIENTOS</option>
 <option value= ".,-"> TRATAMIENTOS DE AGUAS</option>
 <option value= "TRI"> TRATAMIENTOS INDUSTRIALES</option>
 <option value= "803"> TURISMO</option>
 <option value= "804"> UNICULTOR</option>
 <option value= "805"> UNIVERSIDAD</option>
 <option value= "UVA"> UVA PARA PRODUC. DE VINOS</option>
 <option value= "VAL"> VALNEARIO</option>
 <option value= "VAN"> VENTA DE ABONOS</option>
 <option value= "12"> VENTA DE ACERO E INSUMOS INDUSTRIALES</option>
 <option value= "BB1"> VENTA DE ARTICULOS DE BEBE</option>
 <option value= "VAP"> VENTA DE ARTICULOS PLASTICOS</option>
 <option value= "806"> VENTA DE CALZADO</option>
 <option value= "VCO"> VENTA DE COMBUSTIBLE</option>
 <option value= "0.0"> VENTA DE ENERGIA</option>
 <option value= "807"> VENTA DE FILTROS</option>
 <option value= "VGL"> VENTA DE GAS LICUADO</option>
 <option value= "808"> VENTA DE GASES INDUSTRIALES</option>
 <option value= "809"> VENTA DE INSUMOS AGRICOLAS</option>
 <option value= "VDL"> VENTA DE LEÑA </option>
 <option value= "VDM"> VENTA DE MAQUINARIA</option>
 <option value= "V01"> VENTA DE MOTORES Y MAQUINARIAS</option>
 <option value= "VME"> VENTA DE MUEBLES</option>
 <option value= "VN1"> VENTA DE NEUMATICOS</option>
 <option value= "VP2"> VENTA DE PASTO SINTETICO</option>
 <option value= "810"> VENTA DE REPUESTOS</option>
 <option value= "811"> VENTA DE ROPA</option>
 <option value= "812"> VENTA MATERIALES ELECTRICOS</option>
 <option value= "VAC"> VENTA Y ARRIENDO DE CARPAS</option>
 <option value= "X--"> VENTA Y CONFECCION</option>
 <option value= "813"> VENTA Y REPARACION </option>
 <option value= "VEN"> VENTANAS</option>
 <option value= "814"> VENTAS</option>
 <option value= "VAM"> VENTAS  DE ACCESORIOS DE MOTOS</option>
 <option value= "VAA"> VENTAS ART. DE ASEO</option>
 <option value= "VAE"> VENTAS ART. ELECTRONICOS</option>
 <option value= "V03"> VENTAS ARTICULOS DE FERRETERIA</option>
 <option value= "VAV"> VENTAS DE ACCESORIOS DE VEHICULOS</option>
 <option value= "VAD"> VENTAS DE ACSESORIOS DE DECORACION</option>
 <option value= "VDA"> VENTAS DE ALARMAS</option>
 <option value= "AVX"> VENTAS DE AVES EXOTICAS</option>
 <option value= "VVP"> VENTAS DE BOLSAS PLASTICAS</option>
 <option value= "VDC"> VENTAS DE COMIDA</option>
 <option value= "VEI"> VENTAS DE EQUIPOO CONTRA INCENDIO</option>
 <option value= "VEH"> VENTAS DE EQUIPOS HIDRAULICOS</option>
 <option value= "VEP"> VENTAS DE EQUIPOS PROFESIONALES</option>
 <option value= "815"> VENTAS DE HERRAMIENTAS</option>
 <option value= "816"> VENTAS DE INSUMOS</option>
 <option value= "817"> VENTAS DE INSUMOS MADEREROS</option>
 <option value= "818"> VENTAS DE MATERIALES DE CONSTRUCCION</option>
 <option value= "819"> VENTAS DE MATERIALES DE CONTRUCION</option>
 <option value= "EDE"> VENTAS DE MATERIALES Y EQUIPOS PARA LA INDUSTRIA</option>
 <option value= "VRP"> VENTAS DE REP.MINEROS</option>
 <option value= "vss"> ventas de semilla</option>
 <option value= "820"> VENTAS DE VEGETALES PELADOS</option>
 <option value= "EQM"> VENTAS EQUIPOS MEDICOS </option>
 <option value= "13"> VENTAS FIERRO/ACERO Y MAT.CONST.</option>
 <option value= "821"> VENTAS FLORES Y PLANTAS</option>
 <option value= "VPM"> VENTAS POR MAYOR</option>
 <option value= "VMP"> VENTAS POR MENOR</option>
 <option value= "VTE"> VENTAS TECNICAS</option>
 <option value= "822"> VENTAS Y ARRIENDOS ART EVENTOS</option>
 <option value= "839"> VENTAS y EXPORTACION DE FRUTAS</option>
 <option value= "VPC"> VENTAS Y PROD. DE CAUCHO</option>
 <option value= "823"> VENTAS Y SERVICIOS</option>
 <option value= "VYS"> VENTAS Y SERVICOS</option>
 <option value= "824"> VENTILACION INDUSTRIAL</option>
 <option value= "C.-"> VENTILADORES</option>
 <option value= "825"> VESTUARIO</option>
 <option value= "826"> VETERINARIA</option>
 <option value= "VIP"> VIBRADOS</option>
 <option value= "827"> VIDRIERIA</option>
 <option value= "828"> VIDRIOS</option>
 <option value= "829"> VIDRIOS Y ALUMINIOS</option>
 <option value= "830"> VINA</option>
 <option value= "831"> VITIVINICOLA</option>
 <option value= "832"> VITRALES</option>
 <option value= "833"> VIVERO</option>
 <option value= "834"> VIVERO DE PLANTAS</option>
 <option value= "835"> VIVEROS</option>
 <option value= "836"> VIVIENDA</option>
 <option value= "837"> VULCANIZACION</option>
 <option value= "838"> ZOOLOGICO</option>
						     </select>
							</div>
			<div class="required form-group">
				<label for="email">{l s='Email'} <sup>*</sup></label>
				<input type="email" class="is_required validate form-control" data-validate="isEmail" id="email" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}" />
			</div>
			<div class="required password form-group">
				<label for="passwd">{l s='Password'} <sup>*</sup></label>
				<input type="password" class="is_required validate form-control" data-validate="isPasswd" name="passwd" id="passwd" />
				<span class="form_info">{l s='(Five characters minimum)'}</span>
			</div>
			<div class="form-group">
				<label>{l s='Date of Birth'}</label>
				<div class="row">
					<div class="col-xs-4">
						<select id="days" name="days" class="form-control">
							<option value="">-</option>
							{foreach from=$days item=day}
								<option value="{$day}" {if ($sl_day == $day)} selected="selected"{/if}>{$day}&nbsp;&nbsp;</option>
							{/foreach}
						</select>
						{*
							{l s='January'}
							{l s='February'}
							{l s='March'}
							{l s='April'}
							{l s='May'}
							{l s='June'}
							{l s='July'}
							{l s='August'}
							{l s='September'}
							{l s='October'}
							{l s='November'}
							{l s='December'}
						*}
					</div>
					<div class="col-xs-4">
						<select id="months" name="months" class="form-control">
							<option value="">-</option>
							{foreach from=$months key=k item=month}
								<option value="{$k}" {if ($sl_month == $k)} selected="selected"{/if}>{l s=$month}&nbsp;</option>
							{/foreach}
						</select>
					</div>
					<div class="col-xs-4">
						<select id="years" name="years" class="form-control">
							<option value="">-</option>
							{foreach from=$years item=year}
								<option value="{$year}" {if ($sl_year == $year)} selected="selected"{/if}>{$year}&nbsp;&nbsp;</option>
							{/foreach}
						</select>
					</div>
				</div>
			</div>
			{if isset($newsletter) && $newsletter}
				<div class="checkbox">
					<input type="checkbox" name="newsletter" id="newsletter" value="1" {if isset($smarty.post.newsletter) AND $smarty.post.newsletter == 1} checked="checked"{/if} />
					<label for="newsletter">{l s='Sign up for our newsletter!'}</label>
					{if array_key_exists('newsletter', $field_required)}
						<sup> *</sup>
					{/if}
				</div>
			{/if}
			{if isset($optin) && $optin}
				<div class="checkbox">
					<input type="checkbox" name="optin" id="optin" value="1" {if isset($smarty.post.optin) AND $smarty.post.optin == 1} checked="checked"{/if} />
					<label for="optin">{l s='Receive special offers from our partners!'}</label>
					{if array_key_exists('optin', $field_required)}
						<sup> *</sup>
					{/if}
				</div>
			{/if}
		</div>
		{if $b2b_enable}
			<div class="account_creation">
				<h3 class="page-subheading">{l s='Your company information'}</h3>
				<p class="form-group">
					<label for="">{l s='Company'}</label>
					<input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}" />
				</p>
				<p class="form-group">
					<label for="siret">{l s='SIRET'}</label>
					<input type="text" class="form-control" id="siret" name="siret" value="{if isset($smarty.post.siret)}{$smarty.post.siret}{/if}" />
				</p>
				<p class="form-group">
					<label for="ape">{l s='APE'}</label>
					<input type="text" class="form-control" id="ape" name="ape" value="{if isset($smarty.post.ape)}{$smarty.post.ape}{/if}" />
				</p>
				<p class="form-group">
					<label for="website">{l s='Website'}</label>
					<input type="text" class="form-control" id="website" name="website" value="{if isset($smarty.post.website)}{$smarty.post.website}{/if}" />
				</p>
			</div>
		{/if}
		{if isset($PS_REGISTRATION_PROCESS_TYPE) && $PS_REGISTRATION_PROCESS_TYPE}
			<div class="account_creation">
				<h3 class="page-subheading">{l s='Your address'}</h3>
				{foreach from=$dlv_all_fields item=field_name}
					{if $field_name eq "company"}
						{if !$b2b_enable}
							<p class="form-group">
								<label for="company">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}" />
							</p>
						{/if}
					{elseif $field_name eq "vat_number"}
						<div id="vat_number" style="display:none;">
							<p class="form-group">
								<label for="vat_number">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
								<input type="text" class="form-control" id="vat_number" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{/if}" />
							</p>
						</div>
					{elseif $field_name eq "firstname"}
						<p class="required form-group">
							<label for="firstname">{l s='First name'} <sup>*</sup></label>
							<input type="text" class="form-control" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}" />
						</p>
					{elseif $field_name eq "lastname"}
						<p class="required form-group">
							<label for="lastname">{l s='Last name'} <sup>*</sup></label>
							<input type="text" class="form-control" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}" />
						</p>
					{elseif $field_name eq "address1"}
						<p class="required form-group">
							<label for="address1">{l s='Address'} <sup>*</sup></label>
							<input type="text" class="form-control" name="address1" id="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{/if}" />
							<span class="inline-infos">{l s='Street address, P.O. Box, Company name, etc.'}</span>
						</p>
					{elseif $field_name eq "address2"}
						<p class="form-group is_customer_param">
							<label for="address2">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
							<input type="text" class="form-control" name="address2" id="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}" />
							<span class="inline-infos">{l s='Apartment, suite, unit, building, floor, etc...'}</span>
						</p>
					{elseif $field_name eq "postcode"}
						{assign var='postCodeExist' value=true}
						<p class="required postcode form-group">
							<label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
							<input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}"/>
						</p>
					{elseif $field_name eq "city"}
						<p class="required form-group">
							<label for="city">{l s='City'} <sup>*</sup></label>
							<input type="text" class="form-control" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}" />
						</p>
						<!-- if customer hasn't update his layout address, country has to be verified but it's deprecated -->
					{elseif $field_name eq "Country:name" || $field_name eq "country"}
						<p class="required select form-group">
							<label for="id_country">{l s='Country'} <sup>*</sup></label>
							<select name="id_country" id="id_country" class="form-control">
								<option value="">-</option>
								{foreach from=$countries item=v}
								<option value="{$v.id_country}"{if (isset($smarty.post.id_country) AND $smarty.post.id_country == $v.id_country) OR (!isset($smarty.post.id_country) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name}</option>
								{/foreach}
							</select>
						</p>
					{elseif $field_name eq "State:name" || $field_name eq 'state'}
						{assign var='stateExist' value=true}
						<p class="required id_state select form-group">
							<label for="id_state">{l s='State'} <sup>*</sup></label>
							<select name="id_state" id="id_state" class="form-control">
								<option value="">-</option>
							</select>
						</p>
					{/if}
				{/foreach}
				{if $postCodeExist eq false}
					<p class="required postcode form-group unvisible">
						<label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
						<input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}"/>
					</p>
				{/if}
				{if $stateExist eq false}
					<p class="required id_state select unvisible form-group">
						<label for="id_state">{l s='State'} <sup>*</sup></label>
						<select name="id_state" id="id_state" class="form-control">
							<option value="">-</option>
						</select>
					</p>
				{/if}
				<p class="textarea form-group">
					<label for="other">{l s='Additional information'}</label>
					<textarea class="form-control" name="other" id="other" cols="26" rows="3">{if isset($smarty.post.other)}{$smarty.post.other}{/if}</textarea>
				</p>
				{if isset($one_phone_at_least) && $one_phone_at_least}
					<p class="inline-infos">{l s='You must register at least one phone number.'}</p>
				{/if}
				<p class="form-group">
					<label for="phone">{l s='Home phone'}</label>
					<input type="text" class="form-control" name="phone" id="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{/if}" />
				</p>
				<p class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
					<label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>*</sup>{/if}</label>
					<input type="text" class="form-control" name="phone_mobile" id="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{/if}" />
				</p>
				<p class="required form-group" id="address_alias">
					<label for="alias">{l s='Assign an address alias for future reference.'} <sup>*</sup></label>
					<input type="text" class="form-control" name="alias" id="alias" value="{if isset($smarty.post.alias)}{$smarty.post.alias}{else}{l s='My address'}{/if}" />
				</p>
			</div>
			<div class="account_creation dni">
				<h3 class="page-subheading">{l s='Tax identification'}</h3>
				<p class="required form-group">
					<label for="dni">{l s='Identification number'} <sup>*</sup></label>
					<input type="text" class="form-control" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{/if}" />
					<span class="form_info">{l s='DNI / NIF / NIE'}</span>
				</p>
			</div>
		{/if}
		{$HOOK_CREATE_ACCOUNT_FORM}
		<div class="submit clearfix">
			<input type="hidden" name="email_create" value="1" />
			<input type="hidden" name="is_new_customer" value="1" />
			{if isset($back)}<input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}" />{/if}
			<button type="submit" name="submitAccount" id="submitAccount" class="btn btn-default button button-medium">
				<span>{l s='Register'}<i class="icon-chevron-right right"></i></span>
			</button>
			<p class="pull-right required"><span><sup>*</sup>{l s='Required field'}</span></p>
		</div>
	</form>
{/if}
{strip}
{if isset($smarty.post.id_state) && $smarty.post.id_state}
	{addJsDef idSelectedState=$smarty.post.id_state|intval}
{elseif isset($address->id_state) && $address->id_state}
	{addJsDef idSelectedState=$address->id_state|intval}
{else}
	{addJsDef idSelectedState=false}
{/if}
{if isset($smarty.post.id_state_invoice) && isset($smarty.post.id_state_invoice) && $smarty.post.id_state_invoice}
	{addJsDef idSelectedStateInvoice=$smarty.post.id_state_invoice|intval}
{else}
	{addJsDef idSelectedStateInvoice=false}
{/if}
{if isset($smarty.post.id_country) && $smarty.post.id_country}
	{addJsDef idSelectedCountry=$smarty.post.id_country|intval}
{elseif isset($address->id_country) && $address->id_country}
	{addJsDef idSelectedCountry=$address->id_country|intval}
{else}
	{addJsDef idSelectedCountry=false}
{/if}
{if isset($smarty.post.id_country_invoice) && isset($smarty.post.id_country_invoice) && $smarty.post.id_country_invoice}
	{addJsDef idSelectedCountryInvoice=$smarty.post.id_country_invoice|intval}
{else}
	{addJsDef idSelectedCountryInvoice=false}
{/if}
{if isset($countries)}
	{addJsDef countries=$countries}
{/if}
{if isset($vatnumber_ajax_call) && $vatnumber_ajax_call}
	{addJsDef vatnumber_ajax_call=$vatnumber_ajax_call}
{/if}
{if isset($email_create) && $email_create}
	{addJsDef email_create=$email_create|boolval}
{else}
	{addJsDef email_create=false}
{/if}
{/strip}
