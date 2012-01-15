# Sudo default ruleset

class sudo::defaults {
    sudo::rule {"Full access for root":
        entity            => "root",
        as_user           => "ALL",
        password_required => false,
        command           => ["ALL"],
    }
    sudo::rule {"Full access for wheel group":
        entity            => "%wheel",
        as_user           => "ALL",
        password_required => true,
        command           => ["ALL"],
    }
}
