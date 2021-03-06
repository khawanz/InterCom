{* $Id$ *}

<form id="msg_view" class="z-form z-linear" action="{modurl modname="InterCom" type="user" func="deletefromoutbox"}" method="post">
    <fieldset>
        <legend>{$ictitle}</legend>
        <dl class="msg_header">
            <dd class="msg_check"><input name="allbox" id="allbox" onclick="CheckAll();" type="checkbox" value="{gt text="Mark all"}" /></dd>
            <dd class="msg_icon">&nbsp;</dd>
            <dt class="msg_subject">{gt text="Subject"}
                {if $sort neq 5}
                <a href="{modurl modname="InterCom" type='user' func=outbox sort=5}">{img src="black_down.png"}</a>
                {else}{img src="green_down.png"}{/if}
                {if $sort neq 6}
                <a href="{modurl modname="InterCom" type='user' func=outbox sort=6}">{img src="black_up.png"}</a>
                {else}{img src="green_up.png"}{/if}
            </dt>
            <dd class="msg_time">{gt text="Date"}
                {if $sort neq 3}
                <a href="{modurl modname="InterCom" type='user' func=outbox sort=3}">{img src="black_down.png"}</a>
                {else}{img src="green_down.png"}{/if}
                {if $sort neq 4}
                <a href="{modurl modname="InterCom" type='user' func=outbox sort=4}">{img src="black_up.png"}</a>
                {else}{img src="green_up.png"}{/if}
            </dd>
            <dd class="msg_uname">{gt text="Recipient(s)"}
                {if $sort neq 1}
                <a href="{modurl modname="InterCom" type='user' func=outbox sort=1}">{img src="black_down.png"}</a>
                {else}{img src="green_down.png"}{/if}
                {if $sort neq 2}
                <a href="{modurl modname="InterCom" type='user' func=outbox sort=2}">{img src="black_up.png"}</a>
                {else}{img src="green_up.png"}{/if}
            </dd>
            <dd class="msg_view">&nbsp;</dd>
        </dl>

        <div id="msg_listing">
            {section name=message loop=$messagearray}
            {counter assign=zaehlen}
            <dl id="msgheader-{$messagearray[message].msg_id}" class="msg_line {if $zaehlen is odd}odd{elseif $zaehlen is even}even{/if}">
                <dd class="msg_check"><input type="checkbox" onclick="CheckCheckAll();" name="messageid[{$smarty.section.message.index}]" value="{$messagearray[message].msg_id}" /></dd>
                <dd id="msgicon{$messagearray[message].msg_id}" class="msg_icon clickable">
                    {if $messagearray[message].msg_read == 0}
                    {img modname=InterCom src="mail_outbox_unread.png" __title="not read by recipient" }
                    {else}
                    {img modname=core src="mail_generic.png" set="icons/extrasmall" __title="already read by recipient" }
                    {/if}
                </dd>
                <dt class="msg_subject clickable">{if $messagearray[message].msg_subject}{$messagearray[message].msg_subject|truncate:30|safehtml}{else}{gt text="Error! No subject entered."}{/if}</dt>
                <dd class="msg_time clickable">{$messagearray[message].msg_time|dateformat:"datetimebrief"}</dd>
                <dd class="msg_uname clickable"><strong>{$messagearray[message].to_user|truncate:45|safehtml}</strong></dd>
                <dd class="msg_view"><a href="{modurl modname="InterCom" type="user" func="readoutbox" messageid=$messagearray[message].msg_id}">{img modname=core src="demo.png" set="icons/extrasmall" __title="Read" }</a></dd>
            </dl>

            <div id="msgbody-{$messagearray[message].msg_id}" class="msg_body" style="display: none;">

                <div class="z-clearfix">
                    <div class="msg_avatar">
                        {icuseravatar uid=$messagearray[message].from_userid assign='useravatar'}
                        {$messagearray[message].from_userid|profilelinkbyuid:'':$useravatar}
                    </div>

                    <div class="msg_text">
                        {$messagearray[message].msg_text|safehtml|nl2br}{* {$messagearray[message].msg_text|safehtml|modcallhooks|nl2br} *}
                        {if $messagearray[message].signature != ""}<div class="signature">{$messagearray[message].signature|safehtml|nl2br}</div>{/if}
                    </div>
                </div>

                <ul class="msg_links">
                    <li><a class="image view" href="{modurl modname="InterCom" type="user" func="readoutbox" messageid=$messagearray[message].msg_id}">{gt text="Read"}</a></li>
                    <li><a id="print-{$messagearray[message].msg_id}" class="image printer" href="{modurl modname="InterCom" type="user" func="readoutbox" messageid=$messagearray[message].msg_id theme=printer}">{gt text="Print"}</a></li>
                    <li><a id="delete-{$messagearray[message].msg_id}" class="image maildelete" href="{modurl modname="InterCom" type="user" func="deletefromoutbox" messageid=$messagearray[message].msg_id}">{gt text="Delete"}</a></li>
                </ul>

                <div id="information-{$messagearray[message].msg_id}" style="display: none;">&nbsp;</div>

                <div id="msgaction-{$messagearray[message].msg_id}" class="msg_ajaxbody invisible">&nbsp;</div>
            </div>
            {/section}
        </div>

        <div class="ic-buttons msg_footer">
            <input type="submit" name="delete" value="{gt text="Delete marked messages"}" />
        </div>

    </fieldset>

    {if $getmessagecount.outboxlimitreached == 1 && !pnSecAuthAction(0, "InterCom", ".*",ACCESS_ADMIN)}
    {pager show="page" rowcount=$getmessagecount.limitout limit=$messagesperpage posvar=startnum shift=0}
    {else}
    {pager show="page" rowcount=$getmessagecount.totalout limit=$messagesperpage posvar=startnum shift=0}
    {/if}

</form>
