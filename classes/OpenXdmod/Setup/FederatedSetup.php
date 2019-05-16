<?php
namespace OpenXdmod\Setup;

use CCR\DB;

/**
 * Federated setup.
 */
class FederatedSetup extends SubMenuSetupItem
{

    /**
     * menu.
     *
     * @var Menu
     */
    protected $menu;

    /**
     * True if setup should quit.
     *
     * @var bool
     */

    protected $quit;
    /**
     *  Database connection
     *
     *  @var CCR\DB
     */

    /**
     * Instances config.
     *
     * @var array
     */
    protected $instances;
    /**
     * @inheritdoc
     */
    public function __construct(Console $console)
    {
        parent::__construct($console);
        $this->genMenu();
    }

    public function genMenu(){
        $settings = $this->loadIniConfig('portal_settings', 'federated');
        $hubItems = array(
            new MenuItem(
                '2',
                'List current instances',
                new ListFederatedInstancesSetup($this->console, $this)
            ),
            new MenuItem(
                '3',
                'Add new instance',
                new AddFederatedInstanceSetup($this->console, $this)
            )
        );
        $items = array(
            new MenuItem(
                '1',
                'Set Federation Role',
                new SetFederatedRole($this->console, $this)
            ),
        );
        if($settings['federated_role'] === "hub"){
            $items = array_merge($items, $hubItems);
        }
        $items = array_merge(
            $items,
            array(
                new MenuItem(
                    'r',
                    'Return to main menu',
                    new SubMenuQuitSetup($this->console, $this)
                ),
            )
        );
        $this->menu = new Menu($items, $this->console, 'Federated module setup');
    }

    /**
     * @inheritdoc
     */
    public function handle()
    {
        $this->db = DB::factory('datawarehouse');
        $this->quit = false;

        while (!$this->quit) {
            $this->genMenu();
            $this->menu->display();
        }
    }

    /**
     * Call to exit the menu on the next cycle.
     */
    public function quit()
    {
        $this->quit = true;
    }

    /**
     * No options to save data for this submenu
     */
    public function save()
    {
    }

    /**
     * Return the current list of instances.
     *
     * @return array
     */
    public function getInstances()
    {
        return $this->db->query(
            "SELECT
                *
            FROM
                federation_instances
            ORDER BY
                federation_instance_id
        ");
    }

    /**
     * Display the current list of instances
     *
     */
    public function listInstances(){
        $instances = $this->getInstances();

        if (count($instances) == 0) {
            $this->console->displayMessage('No instances have been added.');
            $this->console->displayBlankLine();
        }
        else{
            foreach ($instances as $instance) {
                $this->console->displayMessage('id: ' . $instance['federation_instance_id']);
                $this->console->displayMessage('prefix: ' . $instance['prefix']);
                $extra = json_decode($instance['extra'], true);
                if(count($extra) > 0){
                    foreach($extra as $k => $v){
                        $this->console->displayMessage($k . ': ' . $v);
                    }
                }
                $this->console->displayMessage(str_repeat('-', 72));
                $this->console->displayBlankLine();
            }
        }
    }
}
