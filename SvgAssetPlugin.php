<?php

/**
 * SVG Field plugin for Craft CMS
 *
 * Optimize SVG asset file and display on front-end via <img> or SVG code.
 *
 * @author    Vadim Goncharov
 * @copyright Copyright (c) 2016 Vadim Goncharov
 * @link      http://roundhouseagency.com
 * @package   Analytics
 * @since     1.0.0
 */

namespace Craft;


class SvgAssetPlugin extends BasePlugin
{
    
    public function init()
    {
        parent::init();
    }

    public function getName()
    {
        return Craft::t('SVG Asset');
    }

    public function getDescription()
    {
        return Craft::t('Optimize SVG asset file and display on front-end via <img> or SVG code.');
    }

    public function getDocumentationUrl()
    {
        return '';
    }
    
    public function getReleaseFeedUrl()
    {
        return '';
    }
    
    public function getVersion()
    {
        return '1.0.0';
    }

    public function getSchemaVersion()
    {
        return '1.0.0';
    }
    
    public function getDeveloper()
    {
        return 'Vadim Goncharov';
    }
    
    public function getDeveloperUrl()
    {
        return 'http://roundhouseagency.com';
    }

    public function addTwigExtension()
    {
        Craft::import('plugins.svgasset.twigextensions.SvgAssetTwigExtension');
        return new SvgAssetTwigExtension();
    }

}