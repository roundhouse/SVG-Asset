<?php
namespace Craft;

/**
*                       
*/
class SvgAssetFieldType extends AssetsFieldType
{
    protected $elementType = 'Asset';
    protected $values = array();

    public function getName()
    {
        return Craft::t('SVG Asset');
    }

    public function getInputHtml($name, $criteria)
    {
        craft()->templates->includeJsResource('svgasset/js/vendor/shape.SvgConvert.min.js');
        craft()->templates->includeJsResource('svgasset/js/SvgAssetField.js');
        craft()->templates->includeCssResource("svgasset/css/SvgAssetField.css");

        $id = craft()->templates->formatInputId($name);
        $namespacedId = craft()->templates->namespaceInputId($id);

        $variables = $this->getInputTemplateVariables($name, $criteria);

        $elementId = $this->element ? $this->element->id : null;
        $modelId = $this->model ? $this->model->id : null;

        $variables["svgCodeJs"] = "new Craft.SvgAssetField(\"$namespacedId\");";

        return craft()->templates->render('svgasset/fieldtype/input', $variables);
    }

    public function prepValueFromPost($value)
    {
        $this->values[spl_object_hash($this->element)] = $value;

        if (isset($value["svgCode"])) {
            array_pop($value);
        }

        return parent::prepValueFromPost($value);
        // $dataFiles = array();

        // if (isset($value['data']) && is_array($value['data'])) {
        //     foreach ($value['data'] as $index => $dataString)
        //     {
        //         if (preg_match('/^data:(?<type>[a-z0-9]+\/[a-z0-9]+);base64,(?<data>.+)/i', $dataString, $matches))
        //         {
        //             $type = $matches['type'];
        //             $data = base64_decode($matches['data']);

        //             if (!$data)
        //             {
        //                 continue;
        //             }

        //             if (!empty($value['filenames'][$index]))
        //             {
        //                 $filename = $value['filenames'][$index];
        //             }
        //             else
        //             {
        //                 $extension = FileHelper::getExtensionByMimeType($type);
        //                 $filename = 'Uploaded file.'.$extension;
        //             }

        //             $dataFiles[] = array(
        //                 'filename' => $filename,
        //                 'data' => $data
        //             );
        //         }
        //     }
        // }
    }

}