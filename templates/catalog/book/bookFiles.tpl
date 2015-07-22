{**
 * templates/catalog/book/bookFiles.tpl
 *
 * Copyright (c) 2014-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Displays a book file list with download/payment links in the public catalog.
 *
 * Available data:
 *  $representationId int Publication format ID
 *  $availableFiles array Array of available MonographFiles
 *  $publishedMonograph PublishedMonograph The published monograph object.
 *}

<div class=downloadSection>
	{foreach from=$chapters item=chapter}
	<div class=downloadTableRow>
		<div class="downloadChapterNames">
			<strong>{$chapter->getLocalizedTitle()}</strong>
			{if $chapter->getLocalizedSubtitle() != '' }</br>{$chapter->getLocalizedSubtitle()}{/if}
			{assign var=chapterAuthors value=$chapter->getAuthorNamesAsString()}
			</br><span class="authorName">{$chapterAuthors}</span>
		</div>
		<div class="downloadFiles">
		{foreach from=$publicationFormats item=publicationFormat}
			{assign var=representationId value=$publicationFormat->getId()}
			{foreach from=$availableFiles[$representationId] item=availableFile}
				{if $availableFile->getData('chapterId') == $chapter->getId()}
					{url|assign:downloadUrl op="download" path=$publishedMonograph->getId()|to_array:$representationId:$availableFile->getFileIdAndRevision()}
					<span><a href="{$downloadUrl}"><span title="{$availableFile->getDocumentType()|upper|escape}" class="sprite {$availableFile->getDocumentType()|escape}"></span>{if $availableFile->getDirectSalesPrice()}{translate key="payment.directSales.purchase" amount=$availableFile->getDirectSalesPrice() currency=$currency}{/if}</a>
					</span>
				{/if}
			{/foreach}
		{/foreach}
		</div>
	</div>
	{/foreach}
</div>

<div class=downloadSection>
	{foreach from=$publicationFormats item=publicationFormat}
		{assign var=representationId value=$publicationFormat->getId()}
		{if $publicationFormat->getIsAvailable() && $availableFiles[$representationId]}
			{assign var=filePresent value=false}
			{foreach from=$availableFiles[$representationId] item=availableFile}
				{if $availableFile->getData('chapterId') == ""}
					{assign var=filePresent value=true}
				{/if}
			{/foreach}
			{if $filePresent}
				<div class="downloadTableRow">
					<div class="downloadPublicationFormat">
					<span class="publicationFormatName">{$publicationFormat->getLocalizedName()|escape|upper}</span>
					</div>
				</div>
				{foreach from=$availableFiles[$representationId] item=availableFile}
					{if $availableFile->getData('chapterId') == "" }
					<div class="downloadTableRow">
						<div class="downloadFileNames">
						{$availableFile->getLocalizedName()|escape}
						</div>
						<div class="downloadFiles">
						{url|assign:downloadUrl op="download" path=$publishedMonograph->getId()|to_array:$representationId:$availableFile->getFileIdAndRevision()}
						<span><a href="{$downloadUrl}"><span title="{$availableFile->getDocumentType()|upper|escape}" class="sprite {$availableFile->getDocumentType()|escape}"></span>{if $availableFile->getDirectSalesPrice()}{translate key="payment.directSales.purchase" amount=$availableFile->getDirectSalesPrice() currency=$currency}{/if}</a>
						</span>
						</div>
					</div>
					{/if}
				{/foreach}
			{/if}
		{/if}
	{/foreach}
</div>