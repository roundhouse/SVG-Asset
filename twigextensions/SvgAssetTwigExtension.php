<?php
namespace Craft;

use Twig_Extension;
use Twig_Filter_Method;

class SvgAssetTwigExtension extends \Twig_Extension
{
  /**
   * Returns the name of the extension.
   *
   * @return string The extension name
   */
  public function getName()
  {
    return 'SVG Asset';
  }

  /**
   * Returns a list of filters to add to the existing list.
   *
   * @return array An array of filters
   */
  public function getFilters()
  {
    $returnArray = array();
    $methods = array(
      'sampleFilter',
    );
    foreach ($methods as $methodName) {
      $returnArray[$methodName] = new \Twig_Filter_Method($this, $methodName);
    }
    return $returnArray;

  }

  public function sampleFilter()
  {
    return '';
  }
      
}
