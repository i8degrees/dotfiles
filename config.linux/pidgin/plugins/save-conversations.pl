use Purple;
use Pidgin;
use Storable;

our($pref_none) = '/plugins/core/save-conversations';
our($pref_convs_path) = '/plugins/core/save-conversations/convs_path';

%PLUGIN_INFO = (
    perl_api_version => 2,
    name => 'Save Conversations',
    version => '0.2',
    summary => 'Saves your opened conversations.',
    description => 'Saves your opened conversations at shutdown and restores its at startup.',
    author => 'Pomazyonkov Vitaliy <vitorg@yandex.ru>',
    url => 'http://save-convs.sourceforge.net',
    load => 'plugin_load_cb',
    unload => 'plugin_unload_cb',
    prefs_info => 'prefs_info_cb'
);

sub log {
    my($msg) = shift;
    Purple::Debug::info("save-conversations-plugin", "$msg\n");
}

sub plugin_init {
    &log('plugin_init');

    return %PLUGIN_INFO;
}

sub prefs_info_cb {
    &log('prefs_info_cb');

    my($frame) = Purple::PluginPref::Frame->new();
    $ppref = Purple::PluginPref->new_with_name_and_label($pref_convs_path, "File to save conversations in");
    $ppref->set_type(2);
    $ppref->set_max_length(1024);
    $frame->add($ppref);

    return $frame;
}

sub signed_on_cb {
    &log('signed_on_cb');
    &restore_saved_convs();
}

sub quitting_cb {
    &log('quitting_cb');
    &save_visible_convs();
}

sub plugin_load_cb {
    &log('plugin_load_cb');

    my($plugin) = shift;

    if (!Purple::Prefs::exists($pref_none)) {
        Purple::Prefs::add_none($pref_none);
        my($user_dir) = Purple::Util::user_dir();
        Purple::Prefs::add_string($pref_convs_path, "$user_dir/save-conversations-plugin.store");
    }

    my($purple_conn_h) = Purple::Connections::get_handle();
    Purple::Signal::connect($purple_conn_h, 'signed-on', $plugin, \&signed_on_cb, undef);

    my($purple_core_h) = Purple::get_core();
    Purple::Signal::connect($purple_core_h, 'quitting', $plugin, \&quitting_cb, undef);

    &log('Plugin successfully loaded.');
}

sub plugin_unload_cb {
    &log('plugin_unload_cb');

    my($plugin) = shift;

    &log('Plugin successfully unloaded.');
}

sub get_convs_file {
    return Purple::Prefs::get_string($pref_convs_path);
}

sub restore_saved_convs {
    &log('Reading saved conversations array from file...');

    my(@saved_convs);
    eval {
        @saved_convs =  @{retrieve(&get_convs_file())};
    };
    if (@saved_convs) {
        &log('OK, '.($#saved_convs + 1).' items readed.');
        foreach(@saved_convs) {
            my($name) = $_->{NAME};
            my($type) = $_->{TYPE};
            my($account_name) = $_->{ACCOUNT_NAME};
            my($account_protocol_id) = $_->{ACCOUNT_PROTOCOL_ID};

            &log("Restore PurpleConversation: name='$name', type='$type', account_name='$account_name', account_protocol_id='$account_protocol_id'.");

            my($account) = Purple::Accounts::find($account_name, $account_protocol_id);
            Purple::Conversation->new($type, $account, $name);
        }
    } else {
        &log('There is no conversations to restore.');
    }
}

sub save_visible_convs {
    my(@convs_to_save);

    &log('Searching for active PurpleConversations...');
    my(@convs) = Purple::get_ims();
    if (@convs) {
        foreach(@convs) {
            my($name) = $_->get_name();
            my($type) = $_->get_type();
            my($account_name) = $_->get_account()->get_username();
            my($account_protocol_id) = $_->get_account()->get_protocol_id();

            &log("Found PurpleConversation: name='$name', type='$type', account_name='$account_name', account_protocol_id='$account_protocol_id'. Checking for corresponding PidginConversation visibility...");
            $gtk_conv = Pidgin::Conversation::get_gtkconv($_);
            $is_hidden = $gtk_conv->is_hidden();
            if (!$is_hidden){
                &log('Corresponding PidginConversation is visible, so append it to conversations array.');
                my(%conv) = (NAME => $name, TYPE => $type, ACCOUNT_NAME => $account_name, ACCOUNT_PROTOCOL_ID => $account_protocol_id);
                push(@convs_to_save, \%conv);
            } else {
                &log('Corresponding PidginConversation is hidden, so ignore it.');
            }
        }
    }

    &log('Saving conversations array to file '.&get_convs_file().'...');
    eval {
        $stored = store(\@convs_to_save, &get_convs_file());
    };
    if ($stored) {
        &log('Conversations array successfully saved.');
    } else {
        &log('There was some errors while saving conversations array, array is not saved!');
    }
}