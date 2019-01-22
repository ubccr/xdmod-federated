<?php
namespace OpenXdmod\Setup;

use DateTime;
use CCR\Log;
use ETL\Utilities;
/**
 * Federation Instance setup.
 */
class AddFederatedInstanceSetup extends SetupItem
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
        $this->console->displaySectionHeader('Add Federation Instance');
        $this->console->displayBlankLine();
        $this->console->displayMessage(str_repeat('-', 72));
        $this->console->displayMessage("Current Federation Instances:");
        $this->console->displayMessage(str_repeat('-', 72));
        $instances = $this->parent->listInstances();
        $this->console->displayMessage(str_repeat('-', 72));
        $this->console->displayBlankLine();

        $newExtra = array();

        $url = $this->console->prompt('What is the url of the federated instance:');

        $newExtra['url'] = $url;
        $prefix = preg_replace(array('%^http[s]{0,3}://%', '/[^0-9,a-z,A-Z$_]/'), array('', '_'), $url);
        if (empty($prefix)) {
            $this->console->displayMessage("Error, instance URL is required!");
        }
        else {
            $contact = $this->console->prompt('Who is the contact for this instance:');
            if(!empty($contact)){
                $newExtra['contact'] = $contact;
            }
            $this->console->displayMessage('Adding Instance...');
            $this->addInstance($prefix, $newExtra);
        }

        $this->console->prompt('Press ENTER to continue.');
    }
    public function addInstance($prefix, array $extras){
        $this->parent->db->execute(
            "INSERT INTO modw.federation_instances (`prefix`, `extra`) VALUES (?, ?)
            ON DUPLICATE KEY UPDATE extra = VALUES(extra)",
            array($prefix, json_encode($extras))
        );
        Utilities::runEtlPipeline(
            array('fed.bootstrap', 'fed.bootstrap-cloud'),
            Log::factory(
                'setup-fed-add-instance',
                array(
                    'file' => false,
                    'db' => true,
                    'mail' => false,
                    'console' => true,
                    'consoleLogLevel' => Log::ERR
                )
            ),
            array(
                'variable-overrides' =>
                    array('instance_name' => $prefix)
            )
        );
    }
}
