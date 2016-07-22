<?php
namespace Craft;

class SvgAssetModel extends AssetFileModel
{

    protected function defineAttributes()
    {
        return array_merge(parent::defineAttributes(), array(
            'svgCode' => AttributeType::Mixed,
        ));
    }
}