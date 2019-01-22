<?php

namespace OpenXdmod\Setup;

use DateTime;

/**
 * Resources setup sub-step for listing resources.
 */
class ListFederatedInstancesSetup extends SetupItem
{

    /**
     * Main resources setup
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
        $this->console->displaySectionHeader('Current Federation Instances');
        $instances = $this->parent->listInstances();
        $this->console->prompt('Press ENTER to continue.');
    }
}
