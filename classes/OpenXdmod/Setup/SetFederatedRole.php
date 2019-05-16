<?php
namespace OpenXdmod\Setup;

use DateTime;
use CCR\Log;
use ETL\Utilities;
/**
 * Federation Instance setup.
 */
class SetFederatedRole extends SetupItem
{

    /**
     * Main federation setup
     *
     * @var FederatedSetup
     */
    protected $parent;

    /**
     * @inheritdoc
     */
    public function __construct(Console $console, FederatedSetup $parent)
    {
        parent::__construct($console);
        $this->parent = $parent;
    }

    /**
     * @inheritdoc
     */
    public function handle()
    {
        $settings = $this->loadIniConfig('portal_settings', 'federated');
        $this->console->displaySectionHeader('Set Federation Role');
        $this->console->displayBlankLine();
        $role = strtolower(
            $this->console->prompt(
                'Is this a federation `hub` or `instance`?',
                $settings['federated_role']
            )
        );
        if($role !== $settings['federated_role'])
        {
            switch($role){
                case 'instance':
                    $url = $this->console->prompt('What is the url for the hub?', $settings['federated_huburl']);
                    if (empty($url)) {
                        $this->console->displayMessage("Error, instance URL is required!");
                    }
                    else{
                        if($settings['federated_role'] === 'hub'){
                            $this->patchOpenXdmod(true);
                        }
                        $settings['federated_role'] = 'instance';
                        $settings['federated_huburl'] = $url;
                        $this->saveIniConfig($settings, 'portal_settings', 'federated');
                    }
                break;
                case 'hub':
                    $settings['federated_role'] = 'hub';
                    $this->saveIniConfig($settings, 'portal_settings', 'federated');
                    $this->patchOpenXdmod();
                break;
                default:
                    $this->console->displayMessage("Error, no role specified!");
                    $this->console->prompt('Press ENTER to continue.');
            }
        }
    }
    function patchOpenXdmod($reverse = false){
        $directionOption = '--forward';
        $patchPath = DATA_DIR . '/patches/federated/';
        if($reverse){
            $directionOption = '--reverse';
        }
        $this->executeCommand('patch --quiet ' . $directionOption . ' -up1 --directory=/usr/share/xdmod/  < ' . $patchPath . 'usr-share-xdmod.diff');
        $this->executeCommand('patch --quiet ' . $directionOption . ' -up2 --directory=/etc/xdmod/ < ' . $patchPath . 'configuration.diff');
    }
}
