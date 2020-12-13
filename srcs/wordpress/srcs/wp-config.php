/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   wp-config.php                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/13 12:41:04 by tayamamo          #+#    #+#             */
/*   Updated: 2020/12/13 21:10:29 by tayamamo         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'username' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'wordpress-mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'XxD+khqYz[hO*fY;S%eOlFD&*[0W79Wese%^+kYj-F&S++mV-uZ++Exe9tqYQ70M');
define('SECURE_AUTH_KEY',  '+PH;0)$%$=-J<O)`{x}7+G<;HDJ&KRuJBB,DM6-;HTSx9.<.v,0-f}_Bg]tSn!-{');
define('LOGGED_IN_KEY',    '_Ddd/n=M:w[8x5HIuV*KA_ugP2i`<<aCdP>)Yablus{?h4Ks~vZFx|r~Fq)Z,E^}');
define('NONCE_KEY',        'TALe^O]bMj.4aZ_.d!K;:Bqm[V;MTAUi{TD+_>*@.v>.M@&TNRXoVrlw.(_r?zdv');
define('AUTH_SALT',        'aUHbj6PEDF,]Z6LBHS!D}qE^qo%WF];6D{B$VX0|tzI% W:gyTHr|[Sc2&pK|,%U');
define('SECURE_AUTH_SALT', 'Qm32kzn6Pdx~szk+T_-qyBf3xUh@?zk|tzU@/%;)D(BgbC+D@<H:T[x|Z/SE9sCm');
define('LOGGED_IN_SALT',   'v#])z|`Wy)Ufu]m(:*;jZOzP2.iQ&Hda.-VU<l3O&dUTxnkUf!YM|%f,},7S41h0');
define('NONCE_SALT',       'P^;]OBS-(Yk@)+Jb#tx!8v4D8TEwfc^I.Ca)>%,v{mWg<v_%e#|xqu{HuaV|%6`1');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
