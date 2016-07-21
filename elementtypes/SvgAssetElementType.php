<?php
namespace Craft;

class SvgAssetElementType extends AssetElementType
{
    public function getName()
    {
        return Craft::t('SVG Asset');
    }

    public function populateElementModel($row)
    {
        $model = SvgAssetModel::populateModel($row);
        return $model;
    }
}